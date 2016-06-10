defmodule GithubService.Github.Language do
  use GithubService.Web, :model
  @derive {Poison.Encoder, only: [:owner, :repository, :language, :byte_count]}

  schema "languages" do
    field :owner, :string
    field :repository, :string
    field :language, :string
    field :byte_count, :integer

    timestamps
  end
end
