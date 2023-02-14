defmodule PrintActor do
  def start do
    spawn_link(__MODULE__, :loop, [])
  end

  def loop do
    receive do
      msg ->
        IO.puts("Received message: #{inspect(msg)}")
        loop()
    end
  end
end