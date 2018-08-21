defmodule SupervisorExamples.NonGenServerModule4 do

  # No child spec!

  def my_start_func(args) do
    pid = spawn_link(__MODULE__, :do_stuff, [args])
    {:ok, pid}
  end

  def do_stuff(args) do
    IO.puts "hello world 4 with args: #{inspect args}"
  end
end
