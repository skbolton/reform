defmodule ReformTest do
  use ExUnit.Case
  doctest Reform

  test "greets the world" do
    assert Reform.hello() == :world
  end
end
