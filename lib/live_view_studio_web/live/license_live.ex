defmodule LiveViewStudioWeb.LicenseLive do
  use LiveViewStudioWeb, :live_view

  import Number.Currency

  alias LiveViewStudio.Licenses

  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 3, amount: Licenses.calculate(3))
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Team License</h1>
    <div id="license">
      <div class="card">
        <div class="content">
          <div class="seats">
            <Heroicons.LiveView.icon name="credit-card" type="outline" />
            <span>
              Your license is currently for
              <strong><%= @seats %> <%= ngettext("seat", "seats", @seats) %></strong>
            </span>
          </div>
          <form phx-change="update">
            <input 
              type="range"
              min="1"
              max="10"
              name="seats"
              value={@seats}
            />
          </form>
          <div class="amount">
            <%= number_to_currency(@amount) %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(socket,
        seats: seats,
        amount: Licenses.calculate(seats)
      )

    {:noreply, socket}
  end
end
