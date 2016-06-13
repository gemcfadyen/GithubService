defmodule GithubService.Github.Storage do
  import Ecto.Query
  alias GithubService.Repo
  alias GithubService.Github.User
  alias GithubService.Github.Repository
  alias GithubService.Github.Language

  def write_user(name) do
    Repo.insert(name)
  end

  def find_user(name) do
    query = from u in User, where: u.login == ^name, select: u
    Repo.one(query)
  end

  def write_repository(repository) do
    Repo.insert(repository)
  end

  def find_all_for_user(name) do
    query = from r in Repository, where: r.owner == ^name, select: r
    Repo.all(query)
  end

  def write_languages(owner, repository, languages) do
     Enum.each(languages, fn({language, byte_count}) -> Repo.insert(%Language{owner: owner, repository: repository, language: language, byte_count: byte_count}) end)
  end

  def find_all_languages(owner, repository) do
   query = from l in Language, where: l.owner == ^owner and l.repository == ^repository, select: l
   found_languages = Repo.all(query)

   Enum.reduce(found_languages, %{}, fn(l, acc) -> Map.put(acc, l.language, l.byte_count) end)
  end
end
