defmodule GithubService.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string
      add :public_repos, :integer
      add :repos_url, :string

      timestamps
    end
  end
end
