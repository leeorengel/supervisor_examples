defmodule SupervisorExamples.NonGenServerModule3 do

  def child_spec(args) do
    IO.puts "WHAT IS THE OPTION 3? #{inspect args}"
    %{
      id: __MODULE__,
      start: {__MODULE__, :my_start_func, args},
      type: :worker,
      restart: :transient,
      shutdown: 500
    }
  end

  def my_start_func(arg1, arg2, arg3) do
    pid = spawn_link(__MODULE__, :do_stuff, [[arg1, arg2, arg3]])
    {:ok, pid}
  end

  def do_stuff(args) do
    IO.puts "hello world 3 with args: #{inspect args}"
  end
end
