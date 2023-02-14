defmodule ModifyActor do
  def start do
    spawn_link(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      msg when is_integer(msg) ->
        new_msg = msg + 1
        IO.puts("Received integer: #{msg}, modified to: #{new_msg}")
        loop()

      msg when is_binary(msg) ->
        new_msg = String.downcase(msg)
        IO.puts("Received string: #{msg}, modified to: #{new_msg}")
        loop()

      msg ->
        IO.puts("Received unknown message: #{inspect(msg)}")
        loop()
    end
  end
end