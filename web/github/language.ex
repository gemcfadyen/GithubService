defmodule GithubService.Github.Language do
  use GithubService.Web, :model

  schema "languages" do
    field :user, :string
    field :repository, :string
    field :language, :string
    field :byte_count, :integer

    timestamps
  end
end
