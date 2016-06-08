defmodule GithubService.Github.TransformReposResponse do
  alias GithubService.Github.Repository
  alias GithubService.Github.Owner

  def convert(response) do
    {:ok, repos} = Poison.decode(response, as: [%Repository{owner: %Owner{}}])
    repos
  end
end
