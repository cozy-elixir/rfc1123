defmodule Rfc1123DateTime do
  defmodule Parser do
    import NimbleParsec

    defp month_to_int("Jan"), do: 1
    defp month_to_int("Feb"), do: 2
    defp month_to_int("Mar"), do: 3
    defp month_to_int("Apr"), do: 4
    defp month_to_int("May"), do: 5
    defp month_to_int("Jun"), do: 6
    defp month_to_int("Jul"), do: 7
    defp month_to_int("Aug"), do: 8
    defp month_to_int("Sep"), do: 9
    defp month_to_int("Oct"), do: 10
    defp month_to_int("Nov"), do: 11
    defp month_to_int("Dec"), do: 12

    date =
      ignore(ascii_string([?A..?z], 3))
      |> ignore(string(", "))
      |> choice([integer(2), integer(1)])
      |> ignore(string(" "))
      |> ascii_string([?A..?z], 3)
      |> ignore(string(" "))
      |> integer(4)

    time =
      integer(2)
      |> ignore(string(":"))
      |> integer(2)
      |> ignore(string(":"))
      |> integer(2)
      |> ignore(string(" "))
      |> string("GMT")

    defparsec(
      :datetime,
      date |> ignore(string(" ")) |> concat(time) |> post_traverse({:to_datetime, []})
    )

    defp to_datetime(rest, args, context, _line, _offset) do
      ["GMT", second, minute, hour, year, month, day] = args

      datetime = %DateTime{
        year: year,
        month: month_to_int(month),
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        zone_abbr: "UTC",
        utc_offset: 0,
        std_offset: 0,
        time_zone: "Etc/UTC"
      }

      {rest, [datetime], context}
    end
  end

  def parse(date) do
    case Parser.datetime(date) do
      {:ok, [datetime], _, _, _, _} -> {:ok, datetime}
      {:error, _, _, _, _, _} -> {:error, "Invalid datetime"}
    end
  end
end
