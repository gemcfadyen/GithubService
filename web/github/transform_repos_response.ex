defmodule GithubService.Github.TransformReposResponse do
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner
  alias GithubService.Github.RemoveUpdatedDate

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
      |> RemoveUpdatedDate.remove_date_from(Repository)
    end)
  end

  defp flatten_owner(repository) do
    %{"owner" => %{"login" => owner}} = repository
    %{repository | "owner" => String.downcase(owner)}
  end
end
