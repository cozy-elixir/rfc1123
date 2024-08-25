defmodule RFC2822.DateTime.Parsec do
  # parsec:RFC2822.DateTime.Parsec
  import NimbleParsec

  month =
    choice([
      string("Jan") |> replace(1),
      string("Feb") |> replace(2),
      string("Mar") |> replace(3),
      string("Apr") |> replace(4),
      string("May") |> replace(5),
      string("Jun") |> replace(6),
      string("Jul") |> replace(7),
      string("Aug") |> replace(8),
      string("Sep") |> replace(9),
      string("Oct") |> replace(10),
      string("Nov") |> replace(11),
      string("Dec") |> replace(12)
    ])

  date =
    ignore(ascii_string([?A..?z], 3))
    |> ignore(string(", "))
    |> choice([integer(2), integer(1)])
    |> ignore(string(" "))
    |> concat(month)
    |> ignore(string(" "))
    |> integer(4)

  time =
    integer(2)
    |> ignore(string(":"))
    |> integer(2)
    |> ignore(string(":"))
    |> integer(2)

  zone_abbr =
    ascii_string([?A..?Z], max: 3)

  defparsec(
    :datetime,
    date |> ignore(string(" ")) |> concat(time) |> ignore(string(" ")) |> concat(zone_abbr)
  )

  # parsec:RFC2822.DateTime.Parsec
end
