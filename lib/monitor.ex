defmodule MonitoredActor do
  def start do
    spawn_link(__MODULE__, :loop, [])
  end

  def loop do
    IO.puts("Starting monitored actor...")
    receive do
      :die ->
        IO.puts("Received die message, stopping actor...")
        :ok
    end
  end
end

defmodule MonitoringActor do
  def start do
    {:ok, pid} = spawn_monitor(MonitoredActor, :start, [])
    loop(pid)
  end

  def loop(pid) do
    receive do
      {:DOWN, ref, :process, pid, _reason} ->
        IO.puts("Monitored actor terminated, notifying...")
        send(self(), :die)
        :ok
    end
    loop(pid)
  end
end