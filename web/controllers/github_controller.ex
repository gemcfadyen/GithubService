defmodule GithubService.GithubController do
  use GithubService.Web, :controller
  alias GithubService.Github.GetUserRepositories
  alias GithubService.Github.FetchLanguages
  alias GithubService.Github.FetchUser

  def user(conn, %{"username" => username}) do
    user = username
           |> downcase
           |> FetchUser.with_username

    json conn, user
  end

  def user_repos(conn, %{"username" => username}) do
    repos = username
            |> downcase
            |> GetUserRepositories.execute

    json conn, repos
  end

  def repo_languages(conn, %{"username" => username, "repo_name" => repo_name}) do
    languages = username
                |> downcase
                |> FetchLanguages.for_repository(repo_name)
    json conn, languages
  end

  defp downcase(name), do: String.downcase(name)
end
