defmodule TaskTracker.Repo.Migrations.ManagerBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:managers) do
      add :user_id, references(:users)
    end
  end
end
