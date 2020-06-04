defmodule Bank.MapReader do
  def get(map, key) when is_atom(key), do: Map.get(map, key) || Map.get(map, to_string(key))
  def get(map, key), do: Map.get(map, key) || Map.get(map, String.to_atom(key))
end
