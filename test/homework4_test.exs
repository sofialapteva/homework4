defmodule Homework4Test do
  use ExUnit.Case
  doctest Homework4

  test "initializes with a correct default state" do
    {:ok, pid} = Homework4.start_link()
    assert Homework4.get(pid) == %{state: :stopped}
  end
end
