defmodule GithubService.Github.Repository do
  use GithubService.Web, :model
  @derive {Poison.Encoder, only: [:name, :languages_url, :owner]}

  schema "repositories" do
    field :name, :string
    field :languages_url, :string
    field :owner, :string

    timestamps
  end
end
