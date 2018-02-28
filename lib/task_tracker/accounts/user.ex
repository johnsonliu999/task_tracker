defmodule TaskTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Accounts.User


  schema "users" do
    field :name, :string, null: false
    has_one :manager_part, TaskTracker.Accounts.Manager
    has_many :tasks, TaskTracker.Tasks.Task
    belongs_to :manager, TaskTracker.Accounts.Manager

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :manager_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> foreign_key_constraint(:manager_id)
  end
end
