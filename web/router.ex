defmodule GithubService.Router do
  use GithubService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GithubService do
    pipe_through :api

    get "/users/:username/repos", GithubController, :user_repos
    get "/repos/:username/:repo_name/languages", GithubController, :repo_languages
  end
end
