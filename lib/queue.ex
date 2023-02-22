defmodule QueueActor do
  def start do
    spawn(__MODULE__, :loop, [[]])
  end

  def loop(queue) do
    receive do
      {:push, item} ->
        new_queue = queue ++ [item]
        IO.inspect(new_queue)
        loop(new_queue)
      {:pop, pid} ->
        case queue do
          [] -> send(pid, :empty)
          [head | tail] -> send(pid, { :ok, head })
                           IO.inspect(tail)
                           loop(tail)
        end
    end
  end

  def push(pid, item) do
    send(pid, {:push, item})
  end

  def pop(pid) do
    send(pid, {:pop, self()})
    receive do
      result -> result
    end
  end
end