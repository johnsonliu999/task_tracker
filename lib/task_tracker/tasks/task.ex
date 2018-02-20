defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Tasks.Task


  schema "tasks" do
    field :desc, :string
    field :time, :integer
    field :title, :string
    field :done, :boolean
    belongs_to :user, TaskTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:user_id, :title, :desc, :time, :done])
    |> validate_required([:user_id, :title, :desc, :time, :done])
    |> foreign_key_constraint(:user_id)
  end

  def changeset_update(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:user_id, :title, :desc, :time, :done])
    |> validate_required([:user_id, :title, :desc, :time, :done])
    |> validate_change(:time,
        fn :time, time ->
          if rem(time, 15) != 0 do
            [time: "Only step 15 is allowed"]
          else
            []
          end
        end)
    |> foreign_key_constraint(:user_id)
  end
end
