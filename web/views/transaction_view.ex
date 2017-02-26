defmodule Bgt.TransactionView do
  use Bgt.Web, :view

  defp time_zone_convert(datetime) do
    timezone = Timex.Timezone.get("America/New_York", Timex.now)
    Timex.Timezone.convert(datetime, timezone)
  end

  def format_date(date) do
    Timex.format!(date, "{WDshort}, {Mshort} {D}, {YYYY}")
  end

  def format_time(datetime) do
    datetime |> time_zone_convert |> Timex.format!("{h12}:{m} {AM}")
  end

  def calculate_total(transactions) do
    transactions
    |> Enum.reduce(Decimal.new(0), fn(t, acc) -> Decimal.add(acc, t.amount) end)
    |> Decimal.round(2)
  end
end
