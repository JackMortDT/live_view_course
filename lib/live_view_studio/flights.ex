defmodule LiveViewStudio.Flights do
  @typep times ::
           Timex.Types.valid_datetime()
           | Timex.AmbiguousDateTime.t()
           | {:error, term()}

  @typep flight_t :: %{
           number: String.t(),
           origin: String.t(),
           destination: String.t(),
           departure_time: times(),
           arrival_time: times()
         }

  @spec search_by_number(String.t()) :: list(flight_t())
  def search_by_number(number) do
    Enum.filter(list_flights(), &(&1.number == number))
  end

  @spec search_by_airport(String.t()) :: list(flight_t())
  def search_by_airport(airport) do
    Enum.filter(
      list_flights(),
      &(&1.origin == airport || &1.destination == airport)
    )
  end

  @spec list_flights() :: list(flight_t())
  def list_flights do
    [
      %{
        number: "450",
        origin: "DEN",
        destination: "ORD",
        departure_time: Timex.shift(Timex.now(), days: 1),
        arrival_time: Timex.shift(Timex.now(), days: 1, hours: 2)
      },
      %{
        number: "450",
        origin: "DEN",
        destination: "ORD",
        departure_time: Timex.shift(Timex.now(), days: 2),
        arrival_time: Timex.shift(Timex.now(), days: 2, hours: 2)
      },
      %{
        number: "450",
        origin: "DEN",
        destination: "ORD",
        departure_time: Timex.shift(Timex.now(), days: 3),
        arrival_time: Timex.shift(Timex.now(), days: 3, hours: 2)
      },
      %{
        number: "860",
        origin: "DFW",
        destination: "ORD",
        departure_time: Timex.shift(Timex.now(), days: 1),
        arrival_time: Timex.shift(Timex.now(), days: 1, hours: 3)
      },
      %{
        number: "860",
        origin: "DFW",
        destination: "ORD",
        departure_time: Timex.shift(Timex.now(), days: 2),
        arrival_time: Timex.shift(Timex.now(), days: 2, hours: 3)
      },
      %{
        number: "860",
        origin: "DFW",
        destination: "ORD",
        departure_time: Timex.shift(Timex.now(), days: 3),
        arrival_time: Timex.shift(Timex.now(), days: 3, hours: 3)
      },
      %{
        number: "740",
        origin: "DAB",
        destination: "DEN",
        departure_time: Timex.shift(Timex.now(), days: 1),
        arrival_time: Timex.shift(Timex.now(), days: 1, hours: 4)
      },
      %{
        number: "740",
        origin: "DAB",
        destination: "DEN",
        departure_time: Timex.shift(Timex.now(), days: 2),
        arrival_time: Timex.shift(Timex.now(), days: 2, hours: 4)
      },
      %{
        number: "740",
        origin: "DAB",
        destination: "DEN",
        departure_time: Timex.shift(Timex.now(), days: 3),
        arrival_time: Timex.shift(Timex.now(), days: 3, hours: 4)
      }
    ]
  end
end
