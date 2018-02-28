defmodule TaskTracker.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do

      timestamps()
    end

  end
end
