defmodule GithubService.Github.RemoveUpdatedDate do

  def remove_date_from(entity, entity_type) do
    entity
    |> convert_keys_to_atoms
    |> remove_updated_at_key
    |> convert_map_to_struct(entity_type)
  end

  defp convert_keys_to_atoms(entity) do
    for {key, val} <- entity, into: %{}, do: {String.to_atom(key), val}
  end

  defp remove_updated_at_key(entity) do
    Map.delete(entity, :updated_at)
  end

  defp convert_map_to_struct(entity, entity_type) do
    struct(entity_type, entity)
  end
end

