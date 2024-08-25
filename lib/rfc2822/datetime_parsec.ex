# Generated from lib/rfc2822/datetime_parsec.ex.exs, do not edit.
# Generated at 2024-08-25 08:32:07Z.

defmodule RFC2822.DateTime.Parsec do
  @doc """
  Parses the given `binary` as datetime.

  Returns `{:ok, [token], rest, context, position, byte_offset}` or
  `{:error, reason, rest, context, line, byte_offset}` where `position`
  describes the location of the datetime (start position) as `{line, offset_to_start_of_line}`.

  To column where the error occurred can be inferred from `byte_offset - offset_to_start_of_line`.

  ## Options

    * `:byte_offset` - the byte offset for the whole binary, defaults to 0
    * `:line` - the line and the byte offset into that line, defaults to `{1, byte_offset}`
    * `:context` - the initial context value. It will be converted to a map

  """
  @spec datetime(binary, keyword) ::
          {:ok, [term], rest, context, line, byte_offset}
          | {:error, reason, rest, context, line, byte_offset}
        when line: {pos_integer, byte_offset},
             byte_offset: pos_integer,
             rest: binary,
             reason: String.t(),
             context: map
  def datetime(binary, opts \\ []) when is_binary(binary) do
    context = Map.new(Keyword.get(opts, :context, []))
    byte_offset = Keyword.get(opts, :byte_offset, 0)

    line =
      case Keyword.get(opts, :line, 1) do
        {_, _} = line -> line
        line -> {line, byte_offset}
      end

    case datetime__0(binary, [], [], context, line, byte_offset) do
      {:ok, acc, rest, context, line, offset} ->
        {:ok, :lists.reverse(acc), rest, context, line, offset}

      {:error, _, _, _, _, _} = error ->
        error
    end
  end

  defp datetime__0(
         <<x0, x1, x2, ", ", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 65 and x0 <= 122 and (x1 >= 65 and x1 <= 122) and (x2 >= 65 and x2 <= 122) do
    datetime__1(rest, [] ++ acc, stack, context, comb__line, comb__offset + 5)
  end

  defp datetime__0(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected ASCII character in the range \"A\" to \"z\", followed by ASCII character in the range \"A\" to \"z\", followed by ASCII character in the range \"A\" to \"z\", followed by string \", \"",
     rest, context, line, offset}
  end

  defp datetime__1(<<x0, x1, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) do
    datetime__2(
      rest,
      [x1 - 48 + (x0 - 48) * 10] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 2
    )
  end

  defp datetime__1(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 48 and x0 <= 57 do
    datetime__2(rest, [x0 - 48] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp datetime__1(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\" or ASCII character in the range \"0\" to \"9\"",
     rest, context, line, offset}
  end

  defp datetime__2(<<" ", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__3(rest, [] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp datetime__2(rest, _acc, _stack, context, line, offset) do
    {:error, "expected string \" \"", rest, context, line, offset}
  end

  defp datetime__3(<<"Jan", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, [1] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Feb", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, [2] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Mar", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, [3] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Apr", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, [4] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"May", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, [5] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Jun", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, [6] ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Jul", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, ~c"\a" ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Aug", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, ~c"\b" ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Sep", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, ~c"\t" ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Oct", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, ~c"\n" ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Nov", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, ~c"\v" ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(<<"Dec", rest::binary>>, acc, stack, context, comb__line, comb__offset) do
    datetime__4(rest, ~c"\f" ++ acc, stack, context, comb__line, comb__offset + 3)
  end

  defp datetime__3(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \"Jan\" or string \"Feb\" or string \"Mar\" or string \"Apr\" or string \"May\" or string \"Jun\" or string \"Jul\" or string \"Aug\" or string \"Sep\" or string \"Oct\" or string \"Nov\" or string \"Dec\"",
     rest, context, line, offset}
  end

  defp datetime__4(
         <<" ", x0, x1, x2, x3, " ", x4, x5, ":", x6, x7, ":", x8, x9, " ", rest::binary>>,
         acc,
         stack,
         context,
         comb__line,
         comb__offset
       )
       when x0 >= 48 and x0 <= 57 and (x1 >= 48 and x1 <= 57) and (x2 >= 48 and x2 <= 57) and
              (x3 >= 48 and x3 <= 57) and (x4 >= 48 and x4 <= 57) and (x5 >= 48 and x5 <= 57) and
              (x6 >= 48 and x6 <= 57) and (x7 >= 48 and x7 <= 57) and (x8 >= 48 and x8 <= 57) and
              (x9 >= 48 and x9 <= 57) do
    datetime__5(
      rest,
      [
        x9 - 48 + (x8 - 48) * 10,
        x7 - 48 + (x6 - 48) * 10,
        x5 - 48 + (x4 - 48) * 10,
        x3 - 48 + (x2 - 48) * 10 + (x1 - 48) * 100 + (x0 - 48) * 1000
      ] ++ acc,
      stack,
      context,
      comb__line,
      comb__offset + 15
    )
  end

  defp datetime__4(rest, _acc, _stack, context, line, offset) do
    {:error,
     "expected string \" \", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \" \", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \":\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \":\", followed by ASCII character in the range \"0\" to \"9\", followed by ASCII character in the range \"0\" to \"9\", followed by string \" \"",
     rest, context, line, offset}
  end

  defp datetime__5(rest, acc, stack, context, line, offset) do
    datetime__6(rest, [], [acc | stack], context, line, offset)
  end

  defp datetime__6(rest, acc, stack, context, line, offset) do
    datetime__8(rest, acc, [3 | stack], context, line, offset)
  end

  defp datetime__8(<<x0, rest::binary>>, acc, stack, context, comb__line, comb__offset)
       when x0 >= 65 and x0 <= 90 do
    datetime__9(rest, [x0] ++ acc, stack, context, comb__line, comb__offset + 1)
  end

  defp datetime__8(rest, acc, stack, context, line, offset) do
    datetime__7(rest, acc, stack, context, line, offset)
  end

  defp datetime__7(rest, acc, [_ | stack], context, line, offset) do
    datetime__10(rest, acc, stack, context, line, offset)
  end

  defp datetime__9(rest, acc, [1 | stack], context, line, offset) do
    datetime__10(rest, acc, stack, context, line, offset)
  end

  defp datetime__9(rest, acc, [count | stack], context, line, offset) do
    datetime__8(rest, acc, [count - 1 | stack], context, line, offset)
  end

  defp datetime__10(rest, user_acc, [acc | stack], context, line, offset) do
    _ = user_acc

    datetime__11(
      rest,
      [List.to_string(:lists.reverse(user_acc))] ++ acc,
      stack,
      context,
      line,
      offset
    )
  end

  defp datetime__11(rest, acc, _stack, context, line, offset) do
    {:ok, acc, rest, context, line, offset}
  end
end
