defmodule Eg.Job do
  use Ecto.Schema
  import Ecto.Changeset
  alias Eg.Job


  schema "jobs" do
    field :apply, :string
    field :company, :string
    field :description, :string
    field :email, :string
    field :location, :string
    field :rate, :integer
    field :title, :string
    field :twitter, :string
    field :type, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(%Job{} = job, attrs) do
    job
    |> cast(attrs, [:title, :type, :rate, :location, :description, :company, :url, :twitter, :email, :apply])
    |> validate_required([:title])
  end
end
