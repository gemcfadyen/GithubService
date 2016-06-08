defmodule GithubService.Github.Repository do
  use GithubService.Web, :model

  schema "repositories" do
    field :name, :string
    field :languages_url, :string
    field :owner, :string

    timestamps
  end
end
