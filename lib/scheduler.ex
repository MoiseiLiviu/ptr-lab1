defmodule RiskyBusiness do
  def start_link do
    {:ok, pid} = Task.Supervisor.start_link(name: __MODULE__)
    {:ok, pid}
  end

  def schedule_task(task) do
    # Create a new worker node to perform the task
    {:ok, worker_pid} = Task.Supervisor.async(__MODULE__, fn -> perform_task(task) end)

    # Monitor the worker node and restart it if it crashes
    Process.monitor(worker_pid)

    # Return the worker node's process ID
    worker_pid
  end

  def perform_task(task) do
    # Simulate the worker node's behavior by randomly succeeding or failing
    result = if :rand.uniform() < 0.5 do
      {:ok, "Task completed successfully"}
    else
      {:error, "Worker node crashed"}
    end

    # Print the result if the task completed successfully
    case result do
      {:ok, res} ->
        IO.puts(res)
      {:error, reason} ->
        # Log the crash and restart the worker node
        IO.puts("Worker node crashed: #{reason}")
        perform_task(task)
    end
  end
end