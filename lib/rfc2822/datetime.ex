defmodule RFC2822.DateTime do
  @moduledoc """
  The implementation of RFC 2822 <3.3. Date and Time Specification>.

  > When talking about date time string, RFC 1123 and RFC 2822,
  > they use the same format.

  ## Unsupported features

    * parsing string with zone except `GMT` / `UT` / `UTC` is not supported,
      such as `Mon, 05 Mar 2018 00:00:00 +0000`.

  ## About `UTC`

  In RFC 2822, `UTC` shouldn't be used as a timezone.

  When producing an RFC 2822 date time string, we complied with this rule.

  But, when parsing an RFC 2822 date time string, in order to support 
  non-standard date time strings, we broke this rule.
  """

  @doc """
  Converts the given `datetime` to a string according RFC 2822.

  ## Example

      iex> RFC2822.DateTime.to_string(~U[2000-01-01 00:00:00Z])
      "Sat, 01 Jan 2000 00:00:00 GMT"

  """
  @spec to_string(Calendar.datetime()) :: String.t()
  def to_string(%{zone_abbr: "UTC", time_zone: "Etc/UTC"} = datetime) do
    Calendar.strftime(datetime, "%a, %d %b %Y %H:%M:%S GMT")
  end

  def to_string(_datetime) do
    raise RuntimeError, "only support UTC datetime"
  end

  @doc """
  Parses the extended date time format described by RFC 2822.

  ## Example

      iex> RFC2822.DateTime.parse("Mon, 01 Jan 2000 00:00:00 GMT")
      {:ok, ~U[2000-01-01 00:00:00Z]}

      iex> RFC2822.DateTime.parse("Mon, 01 Jan 2000 00:00:00 UT")
      {:ok, ~U[2000-01-01 00:00:00Z]}

      iex> RFC2822.DateTime.parse("Mon, 01 Jan 2000 00:00:00 UTC")
      {:ok, ~U[2000-01-01 00:00:00Z]}

  """
  @spec parse(String.t()) :: {:ok, DateTime.t()} | {:error, atom()}
  def parse(string) do
    case RFC2822.DateTime.Parsec.datetime(string) do
      {:ok, terms, _, _, _, _} ->
        to_result(terms)

      {:error, _, _, _, _, _} ->
        {:error, :invalid_format}
    end
  end

  defp to_result([day, month, year, hour, minute, second, zone_abbr])
       when zone_abbr in ["GMT", "UT", "UTC"] do
    datetime = %DateTime{
      year: year,
      month: month,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
      utc_offset: 0,
      std_offset: 0,
      zone_abbr: "UTC",
      time_zone: "Etc/UTC"
    }

    {:ok, datetime}
  end

  defp to_result(_) do
    {:error, :unsupported_zone}
  end
end
