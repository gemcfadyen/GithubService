defmodule GithubService.Github.User do
  use GithubService.Web, :model
  @derive {Poison.Encoder, only: [:login, :public_repos, :repos_url]}

  schema "users" do
    field :login, :string
    field :public_repos, :integer
    field :repos_url, :string

    timestamps
  end
end
