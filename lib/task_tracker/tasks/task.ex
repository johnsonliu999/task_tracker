defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Tasks.Task


  schema "tasks" do
    field :desc, :string
    field :title, :string
    field :done, :boolean
    belongs_to :user, TaskTracker.Accounts.User
    has_many :time_blocks, TaskTracker.Tasks.TimeBlock

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:user_id, :title, :desc, :done])
    |> validate_required([:user_id, :title, :desc, :done])
    |> foreign_key_constraint(:user_id)
  end

  def changeset_update(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:user_id, :title, :desc, :done])
    |> validate_required([:user_id, :title, :desc, :done])
    |> foreign_key_constraint(:user_id)
  end
end
