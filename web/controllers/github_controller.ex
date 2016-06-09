defmodule GithubService.GithubController do
  use GithubService.Web, :controller
  alias GithubService.Github.GetUserRepositories

  def user_repos(conn, %{"username" => username}) do
    repos = GetUserRepositories.execute(username)

    json conn, repos
  end

  def repo_languages(conn, %{"username" => username, "repo_name" => repo_name}) do

    send_resp(conn, 200, "")
  end
end
