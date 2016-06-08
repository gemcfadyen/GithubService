defmodule GithubService.Router do
  use GithubService.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubService do
    pipe_through :api
  end
end
