defmodule Homework4Test do
  use ExUnit.Case
  doctest Homework4

  test "initializes with a correct default state" do
    Homework4.start_link()
    assert Homework4.get() == :stopped
  end
end
