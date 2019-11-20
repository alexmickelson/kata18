defmodule Kata18 do

  def expand_dependencies(%{} = unexpanded) do
    Enum.reduce(unexpanded, %{},
    fn {key, value}, acc ->
        Map.put(acc, key, sorted_expanded_dependencies(unexpanded, value))
    end)
  end

  def sorted_expanded_dependencies(unexpanded, value) do
    do_expand_dependencies(unexpanded, [], value)
    |> :lists.sort
  end

  def do_expand_dependencies(%{} = unexpanded, previously_processed, [next_dependency | rest]) do
    case Enum.member?(previously_processed, next_dependency) do
      :true ->
        do_expand_dependencies(unexpanded, previously_processed, rest)
      :false ->
        previously_processed = [next_dependency | previously_processed]
        rest = Map.get(unexpanded, next_dependency, []) ++ rest
        [next_dependency] ++ do_expand_dependencies(unexpanded, previously_processed, rest)
    end
  end

  def do_expand_dependencies(%{}, _, []) do
    []
  end
end
