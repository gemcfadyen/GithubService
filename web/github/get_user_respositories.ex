defmodule GithubService.Github.GetUserRepositories do
  alias GithubService.Github.Client
  alias GithubService.Github.TransformReposResponse
  alias GithubService.Github.Storage

  def execute(username) do
    Storage.find_all_for_user(username)
    |> retrieve_repositories(username)
  end

  defp retrieve_repositories([], username) do
    all_repos = Client.get_repositories_for(username)
    |> TransformReposResponse.convert

    Enum.each(all_repos, fn(r) -> Storage.write(r) end)
    all_repos
  end
  defp retrieve_repositories(repos, _username), do: repos
end

