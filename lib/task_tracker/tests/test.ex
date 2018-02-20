defmodule TaskTracker.Tests.Test do
  use Ecto.Schema
  import Ecto.Changeset
  alias TaskTracker.Tests.Test


  schema "tests" do
    field :test, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%Test{} = test, attrs) do
    test
    |> cast(attrs, [:test])
    |> validate_required([:test])
  end
end
