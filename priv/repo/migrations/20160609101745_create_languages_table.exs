defmodule GithubService.Repo.Migrations.CreateLanguagesTable do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :user, :string
      add :repository, :string
      add :language, :string
      add :byte_count, :integer

      timestamps
    end
  end
end
