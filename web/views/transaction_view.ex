defmodule Bgt.TransactionView do
  use Bgt.Web, :view

  defp time_zone_convert(datetime) do
    timezone = Timex.Timezone.get("America/New_York", Timex.now)
    Timex.Timezone.convert(datetime, timezone)
  end

  defp compare(t_a, t_b) do
    Ecto.Time.compare(t_a |> to_tz_time, t_b |> to_tz_time)
  end

  defp to_tz_time(datetime) do
    datetime |> time_zone_convert |> Ecto.DateTime.cast! |> Ecto.DateTime.to_time
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

  def sort_transactions(transactions) do
    transactions
    |> Enum.sort(fn(t_a, t_b) ->
      if compare(t_a.inserted_at, t_b.inserted_at) == -1, do: true, else: false
    end)
  end
end
