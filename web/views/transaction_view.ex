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

  def format_tz_time(datetime) do
    datetime |> time_zone_convert |> Timex.format!("{h12}:{m} {AM}")
  end

  def format_time({h, m, _, _}) do
    {{1900, 1, 1}, {h, m, 0}} |> Timex.format!("{h12}:{m} {AM}")
  end

  def calculate_total(transactions) do
    transactions
    |> Enum.reduce(Decimal.new(0), fn(t, acc) -> Decimal.add(acc, t.amount) end)
    |> Decimal.round(2)
  end

  def sort_transactions(transactions) do
    transactions
    |> Enum.sort(&(compare(&1.inserted_at, &2.inserted_at)) == -1)
  end

  def list_transactions(transactions, conn, markup \\ [], date \\ nil)
  def list_transactions([], _, markup, _), do: Phoenix.HTML.raw markup
  def list_transactions([h | t], conn, markup, date) do
    new_markup =
      if date != h.date do
        {:safe, row_markup} = render "_date_row.html", conn: conn, transaction: h
        row_markup
      else
        {:safe, row_markup} = render "_row.html", conn: conn, transaction: h
        row_markup
      end
    list_transactions(t, conn, [markup|new_markup], h.date)
  end
end
