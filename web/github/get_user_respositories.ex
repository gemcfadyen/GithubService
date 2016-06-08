defmodule GithubService.Github.GetUserRepositories do
  alias GithubService.Github.Client
  alias GithubService.Github.TransformReposResponse
  alias GithubService.Github.Storage

  def execute(username) do
    Storage.find_all_for_user(username)
    |> retrieve_repositories(username)
  end

  defp retrieve_repositories([], username) do
    Client.get_repositories_for(username)
    |> TransformReposResponse.convert
  end
  defp retrieve_repositories(repos, _username), do: repos
end

