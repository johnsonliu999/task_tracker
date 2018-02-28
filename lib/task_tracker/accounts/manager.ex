defmodule TaskTracker.Accounts.Manager do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Accounts.Manager


  schema "managers" do
    has_many :underlings, TaskTracker.Accounts.User
    belongs_to :user, TaskTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Manager{} = manager, attrs) do
    manager
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
  end
end
