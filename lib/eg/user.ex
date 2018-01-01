defmodule Eg.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eg.User

  schema "users" do
    # field :id, :integer
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :jobs, Eg.Job

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end

end
