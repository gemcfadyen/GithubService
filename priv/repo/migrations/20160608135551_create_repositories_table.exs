defmodule GithubService.Repo.Migrations.CreateRepositoriesTable do
  use Ecto.Migration

  def change do
    create table(:repositories) do
      add :name, :string
      add :languages_url, :string
      add :owner, :string

      timestamps
    end
  end
end
