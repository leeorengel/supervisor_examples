defmodule SupervisorExamplesTest do
  use ExUnit.Case
  doctest SupervisorExamples

  test "greets the world" do
    assert SupervisorExamples.hello() == :world
  end
end
