defmodule LiveViewStudioWeb.FlightLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights

  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        number: "",
        flights: [],
        loading: false
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Find a flight</h1>
    <div id="search">

      <form phx-submit="flight-search">
        <input
          type="text"
          name="number"
          value={@number}
          placeholder="Flight number"
          autofocus
          autocomplete="off"
          readonly={@loading}
        />
        <button type="submit">
          <img src="images/search.svg">
        </button>
      </form>

      <%= if @loading do %>
        <div class="loader">Loading...</div>
      <% end %>

      <div class="flights">
        <ul>
          <%= for flight <- @flights do %>
            <li>
              <div class="first-line">
                <div class="number">
                  Flight #<%= flight.number %>
                </div>
                <div class="origin-destination">
                  <img src="images/location.svg">
                  <%= flight.origin %> to
                  <%= flight.destination %>
                </div>
              </div>
              <div class="second-line">
                <div class="departs">
                  Departs: <%= flight.departure_time %>
                </div>
                <div class="arrives">
                  Arrives: <%= flight.arrival_time %>
                </div>
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("flight-search", %{"number" => number}, socket) do
    send(self(), {:run_flight_search, number})

    socket =
      assign(socket,
        flights: [],
        loading: true,
        number: number
      )

    {:noreply, socket}
  end

  @impl true
  def handle_info({:run_flight_search, number}, socket) do
    case Flights.search_by_number(number) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No flights matching \"#{number}\"")
          |> assign(flights: [], loading: false)

        {:noreply, socket}

      flights ->
        socket =
          socket
          |> clear_flash()
          |> assign(flights: flights, loading: false)

        {:noreply, socket}
    end
  end
end
