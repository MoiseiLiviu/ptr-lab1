defmodule AverageActor do
  def start do
    spawn(__MODULE__, :loop, [0, 0])
  end

  def loop(sum, count) do
    receive do
      number when is_number(number) ->
        new_sum = sum + number
        new_count = count + 1
        IO.puts("Current average is #{new_sum / new_count}")
        loop(new_sum, new_count)
    end
  end
end
