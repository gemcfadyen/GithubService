defmodule GithubService.Repo.Migrations.RenameLoginFieldOnUser do
  use Ecto.Migration

  def change do
    rename table(:users), :login, to: :owner
  end
end
