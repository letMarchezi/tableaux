defmodule SeqTest do
  use ExUnit.Case
  doctest Seq

  test "greets the world" do
    assert Seq.hello() == :world
  end
end
