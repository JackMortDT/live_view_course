defmodule LiveViewStudio.Airports do
  @spec suggest(String.t()) :: list()
  def suggest(""), do: []

  def suggest(prefix) do
    Enum.filter(codes(), &has_prefix?(&1, prefix))
  end

  @spec has_prefix?(String.t(), String.t()) :: boolean()
  defp has_prefix?(city, prefix) do
    String.starts_with?(String.downcase(city), String.downcase(prefix))
  end

  @spec codes() :: list(String.t())
  def codes do
    [
      "ATL",
      "LAX",
      "ORD",
      "DFW",
      "DEN",
      "DBA",
      "JFK",
      "SFO",
      "SEA",
      "LAS",
      "MCO",
      "EWR",
      "CLT",
      "PHX",
      "IAH",
      "MIA",
      "BOS",
      "MSP",
      "FLL",
      "DTW",
      "PHL",
      "LGA",
      "BWI",
      "SLC",
      "SAN",
      "IAD",
      "DCA",
      "MDW",
      "TPA",
      "PDX",
      "HNL"
    ]
  end
end
