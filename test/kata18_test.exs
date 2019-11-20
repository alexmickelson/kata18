defmodule Kata18Test do
  use ExUnit.Case
  alias Kata18
  # doctest Kata18

  test "one dependency expands to itself" do
    unexpanded = %{
      "A" => ["B"]
    }
    actual = Kata18.expand_dependencies(unexpanded)
    assert actual == unexpanded
  end

  test "can expand a dependency list" do
    unexpanded = %{
      "A" => ["B"],
      "B" => ["C"]
    }
    actual = Kata18.expand_dependencies(unexpanded)
    expected = %{
      "A" => ["B", "C"],
      "B" => ["C"]
    }
    assert actual == expected
  end

  test "works with full input of kata" do
    unexpanded = %{
      "A" => ["B", "C"],
      "B" => ["C", "E"],
      "C" => ["G"],
      "D" => ["A", "F"],
      "E" => ["F"],
      "F" => ["H"]
    }
    actual = Kata18.expand_dependencies(unexpanded)
    expected = %{
      "A" => ["B", "C", "E", "F", "G", "H"],
      "B" => ["C", "E", "F", "G", "H"],
      "C" => ["G"],
      "D" => ["A", "B", "C", "E", "F", "G", "H"],
      "E" => ["F", "H"],
      "F" => ["H"]
    }
    assert actual == expected
  end

  test "recursive dependency" do
    unexpanded = %{
      "A" => ["B"],
      "B" => ["C"],
      "C" => ["A"]
    }
    actual = Kata18.expand_dependencies(unexpanded)
    expected = %{
      "A" => ["A", "B", "C"],
      "B" => ["A", "B", "C"],
      "C" => ["A", "B", "C"]
    }
    assert actual == expected

  end
end
