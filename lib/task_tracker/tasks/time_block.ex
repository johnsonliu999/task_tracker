defmodule TaskTracker.Tasks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Tasks.TimeBlock


  schema "time_blocks" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    belongs_to :task, TaskTracker.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end])
    |> validate_required([:start, :end])
  end
end
