defmodule EtlAppTest do
  use ExUnit.Case
  doctest EtlApp

  test "greets the world" do
    assert EtlApp.hello() == :world
  end
end
