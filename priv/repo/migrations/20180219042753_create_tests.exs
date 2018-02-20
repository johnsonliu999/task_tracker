defmodule TaskTracker.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add :test, :boolean, default: false, null: false

      timestamps()
    end

  end
end
