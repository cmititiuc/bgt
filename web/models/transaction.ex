defmodule Bgt.Transaction do
  use Bgt.Web, :model

  schema "transactions" do
    field :amount, :decimal
    field :description, :string
    belongs_to :user, Bgt.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:amount, :description, :inserted_at])
    |> validate_required([:amount, :description])
  end
end
