defmodule GithubService.Github.Storage do
  import Ecto.Query
  alias GithubService.Repo
  alias GithubService.Github.Repository
  alias GithubService.Github.Language

  def write_repository(repository) do
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

  def write_languages(user, repository, languages) do
     Enum.each(languages, fn({language, byte_count}) -> Repo.insert(%Language{user: user, repository: repository, language: language, byte_count: byte_count}) end)
  end

  def find_all_languages(user, repository) do
   query = from l in Language, where: l.user == ^user and l.repository == ^repository, select: l
   Repo.all(query)
  end
end
