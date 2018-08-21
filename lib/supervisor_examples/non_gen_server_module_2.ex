defmodule SupervisorExamples.NonGenServerModule2 do

  def child_spec(opts) do
    IO.puts "WHAT IS THE OPTION 2? #{inspect opts}"
    %{
      id: __MODULE__,
      start: {__MODULE__, :my_start_func, [opts]},
      type: :worker,
      restart: :transient,
      shutdown: 500
    }
  end

  def my_start_func(opts) do
    pid = spawn_link(__MODULE__, :do_stuff, [opts])
    {:ok, pid}
  end

  def do_stuff(args) do
    IO.puts "hello world 2 with args: #{inspect args}"
  end
end
