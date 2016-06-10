defmodule GithubService.Repo.Migrations.RenameUserFieldOnLanguages do
  use Ecto.Migration

  def change do
    rename table(:languages), :user, to: :owner
  end
end
