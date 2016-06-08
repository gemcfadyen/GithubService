defmodule GithubService.GithubController do
  use GithubService.Web, :controller
  alias GithubService.Github.GetUserRepositories

  def user_repos(conn, %{"username" => username}) do
    repos = GetUserRepositories.execute(username)

    json conn, repos
  end
end
