defmodule SupervisorExamples.GenServerModule do

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(args) do
    IO.puts "hello world from genserver with args: #{inspect args}"
    {:ok, %{}}
  end

  def handle_call(_msg, _from, state) do
    {:reply, :ok, state}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end
end