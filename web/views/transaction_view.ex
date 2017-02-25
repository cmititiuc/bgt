defmodule Bgt.TransactionView do
  use Bgt.Web, :view

  defp time_zone_convert(datetime) do
    timezone = Timex.Timezone.get("America/New_York", Timex.now)
    Timex.Timezone.convert(datetime, timezone)
  end

  def format_date(datetime) do
    datetime |> time_zone_convert |> Timex.format!("{WDshort}, {Mshort} {D}, {YYYY}")
  end

  def format_time(datetime) do
    datetime |> time_zone_convert |> Timex.format!("{h12}:{m} {AM}")
  end
end
