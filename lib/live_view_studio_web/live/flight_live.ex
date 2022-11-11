defmodule LiveViewStudioWeb.FlightLive do
  use LiveViewStudioWeb, :live_view

  alias LiveViewStudio.Flights
  alias LiveViewStudio.Airports

  @format_date "%d/%m/%Y %H:%M:%S"

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(
        socket,
        number: "",
        flights: [],
        matches: [],
        loading: false,
        airport_code: ""
      )

    {:ok, socket}
  end

  @impl true
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

      <form phx-submit="airport-search" phx-change="suggest-airport">
        <input
          type="text"
          name="airport_code"
          value={@airport_code}
          placeholder="Airport code"
          autocomplete="off"
          list="matches"
          phx-debounce="1000"
          readonly={@loading}
        />
        <button type="submit">
          <img src="images/search.svg">
        </button>
      </form>

      <datalist id="matches">
        <%= for match <- @matches do %>
          <option value={match}><%= match %></option>
        <% end %>
      </datalist>

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
                  Departs: <%= format_date(flight.departure_time) %>
                </div>
                <div class="arrives">
                  Arrives: <%= format_date(flight.arrival_time) %>
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
  def handle_event("suggest-airport", %{"airport_code" => airport_code}, socket) do
    socket = assign(socket, matches: Airports.suggest(airport_code))
    {:noreply, socket}
  end

  @impl true
  def handle_event("airport-search", %{"airport_code" => airport_code}, socket) do
    send(self(), {:run_airport_search, airport_code})

    socket =
      assign(socket,
        number: "",
        flights: [],
        loading: true,
        airport_code: airport_code
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("flight-search", %{"number" => number}, socket) do
    send(self(), {:run_flight_search, number})

    socket =
      assign(socket,
        airport_code: "",
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

  @impl true
  def handle_info({:run_airport_search, airport_code}, socket) do
    case Flights.search_by_airport(airport_code) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No flights matching \"#{airport_code}\"")
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

  defp format_date(date), do: Timex.format!(date, @format_date, :strftime)
end
