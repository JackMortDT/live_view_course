defmodule LiveViewStudio.Sales do
  @spec new_orders() :: integer()
  def new_orders, do: Enum.random(5..20)

  @spec sales_amount() :: integer()
  def sales_amount, do: Enum.random(100..1000)

  @spec satisfaction() :: integer()
  def satisfaction, do: Enum.random(95..100)
end
