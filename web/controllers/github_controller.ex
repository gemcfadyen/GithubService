defmodule GithubService.GithubController do
  use GithubService.Web, :controller
  alias GithubService.Github.GetUserRepositories
  alias GithubService.Github.FetchLanguages

  def user_repos(conn, %{"username" => username}) do
    repos = GetUserRepositories.execute(username)

    json conn, repos
  end

  def repo_languages(conn, %{"username" => username, "repo_name" => repo_name}) do
    languages = FetchLanguages.for_repository(username, repo_name)
    json conn, languages
  end
end
