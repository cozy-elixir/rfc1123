defmodule Rfc1123DateTime do
  @moduledoc """
  RFC 1123 date time parser.
  """

  @doc """
  Format a RFC 1123 date time string.

  ## Example
    iex> Rfc1123DateTime.to_string(~U[2000-01-01 00:00:00Z])
    "Sat, 01 Jan 2000 00:00:00 GMT"
  """
  def to_string(datetime) do
    Calendar.strftime(datetime, "%a, %d %b %Y %H:%M:%S GMT")
  end

  @doc """
  Parse a RFC 1123 date time string.

  ## Example
    iex> Rfc1123DateTime.parse("Mon, 01 Jan 2000 00:00:00 GMT")
    {:ok, ~U[2000-01-01 00:00:00Z]}
  """

  def parse(date) do
    case Rfc1123DateTime.Parsec.datetime(date) do
      {:ok, args, _, _, _, _} ->
        {:ok, to_datetime(args)}

      {:error, expected, got, _, _, line} ->
        {:error, "#{expected}, got: '#{got}' at offset #{line}"}
    end
  end

  defp to_datetime([day, month, year, hour, minute, second, "GMT"]) do
    %DateTime{
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      zone_abbr: "UTC",
      utc_offset: 0,
      std_offset: 0,
      time_zone: "Etc/UTC"
    }
  end
end
