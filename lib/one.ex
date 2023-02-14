alias :math, as: Math

defmodule One do
  def hello() do
    IO.puts("Hello, PTR!")
  end

  def is_prime?(n) when n < 2 do
    false
  end

  def is_prime?(n) when n < 4 do
    true
  end

  def is_prime?(n) when n > 1 do
    nums = 2..(n - 1)
    Enum.all?(nums, fn x -> rem(n, x) != 0 end)
  end

  def cylinder_area(h, r) do
    2 * Math.pi * r * (r + h)
  end

  def reverse_list(list, acc \\ []) do
    case list do
      [] -> acc
      [head | tail] -> reverse_list(tail, [head | acc])
    end
  end

  def unique_sum(list) do
    Enum.uniq(list) |> Enum.sum()
  end

  def extract_random_list(list, n) do
    Enum.take_random(list, n)
  end

  def first_fibonacci(n) when n == 1 do
    [1]
  end

  def first_fibonacci(n) when n == 2 do
    [1, 1]
  end

  def first_fibonacci(n) when n > 2 do
    fib = first_fibonacci(n - 1)
    next_number = Enum.at(fib, n - 2) + Enum.at(fib, n - 3)
    fib ++ [next_number]
  end

  def translate(dictionary, text) do
    Enum.map(text, fn word -> Map.get(dictionary, word, word) end)
  end

  def smallestNumber(a, b, c) do
    list = Enum.sort([a, b, c])
    zeroes = Enum.count(list, &(&1 == 0))
    if zeroes == 3 do
      0
    else
      if zeroes == 2 do
        rotateLeft(list, 2) |> Enum.join()
      end
      if zeroes == 1 do
        Enum.reverse(rotateLeft(list, 2)) |> Enum.join()
      else
        Enum.join(list)
      end
    end
  end

  def rotateLeft(list, n) do
    {left, right} = Enum.split(list, rem(n, length(list)))
    right ++ left
  end

  def  listRightAngleTriangles do
    Enum.reduce 1..20, [], fn a, acc ->
      Enum.reduce 1..20, acc, fn b, acc ->
        c = Math.sqrt(a*a + b*b)
        if c == trunc(c) do
          [{a, b, trunc(c)} | acc]
        else
          acc
        end
      end
    end
  end

  def remove_consecutive_duplicates(list) do
    Enum.reduce(list, [], fn x, acc ->
      if Enum.at(acc, -1) == x do
        acc
      else
        acc ++ [x]
      end
    end)
  end

  def one_row_words(list) do
    rows = [
      "qwertyuiop",
      "asdfghjkl",
      "zxcvbnm"
    ]

    for row <- rows,
        word <- list,
        Enum.all?(word |> String.downcase() |> String.graphemes(), fn x ->
          String.contains?(row, x)
        end) do
      word
    end
  end

  def encode(message, shift) do
    String.to_charlist(message)
    |> Enum.map(fn letter -> shiftChar(letter, shift) end)
    |> List.to_string
  end

  defp shiftChar(letter, shift) do
    cond do
      letter in ?a..?z -> rem(letter - ?a + shift, 26) + ?a
      letter in ?A..?Z -> rem(letter - ?A + shift, 26) + ?A
      true -> letter
    end
  end

  def decode(message, shift) do
    encode(message, -shift)
  end

  def group_anagrams(strings) do
    strings
    |> Enum.group_by(fn string ->
      string
      |> String.downcase()
      |> String.split("")
      |> Enum.sort()
      |> List.to_string()
    end)
    |> Enum.map(fn {_key, group} -> group end)
    |> Enum.to_list()
  end

  def common_prefix(strings) do
    Enum.reduce(strings, fn string, acc ->
      if String.starts_with?(string, acc) do
        acc
      else
        common_prefix(string, acc)
      end
    end)
  end

  def common_prefix(string1, string2) do
    <<head1, tail1::binary>> = string1
    <<head2, tail2::binary>> = string2

    if head1 == head2 do
      <<head1>> <> common_prefix(tail1, tail2)
    else
      <<>>
    end
  end

  def factorize(n) do
    factorize(n, 2)
  end

  defp factorize(n, i) when n == 1 do
    []
  end

  defp factorize(n, i) do
    if is_prime?(i) && rem(n, i) == 0 do
      [i | factorize(round(n / i), i)]
    else
      factorize(n, i + 1)
    end
  end
end