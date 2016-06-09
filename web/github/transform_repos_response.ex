defmodule GithubService.Github.TransformReposResponse do
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner

  def convert(raw_response) do
    raw_response
    |> parse
    |> clean
  end

  defp parse(response) do
    Poison.Parser.parse!(response, as: [%Repository{owner: %Owner{}}])
  end

  defp clean(repos) do
    Enum.map(repos, fn(repository) ->
      repository
      |> flatten_owner
      |> convert_keys_to_atoms
      |> remove_updated_at_key
      |> convert_map_to_struct
    end)
  end

  defp flatten_owner(repository) do
    %{"owner" => %{"login" => owner}} = repository
    %{repository | "owner" => String.downcase(owner)}
  end

  defp convert_keys_to_atoms(repository) do
    for {key, val} <- repository, into: %{}, do: {String.to_atom(key), val}
  end

  defp remove_updated_at_key(repository) do
    Map.delete(repository, :updated_at)
  end

  defp convert_map_to_struct(repository) do
    struct(Repository, repository)
  end
end
