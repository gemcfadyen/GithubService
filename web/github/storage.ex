defmodule GithubService.Github.Storage do
  import Ecto.Query
  alias GithubService.Repo
  alias GithubService.Github.Repository

  def write(repository) do
    repo = %Repository{
      name: repository.name,
      languages_url: repository.languages_url,
      owner: repository.owner.login
    }

    Repo.insert(repo)
  end

  def find_all_for_user(name) do
    query = from r in Repository, where: r.owner == ^name, select: r
    Repo.all(query)
  end
end
