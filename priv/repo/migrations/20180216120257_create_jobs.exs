defmodule Eg.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :type, :string
      add :rate, :integer
      add :location, :string
      add :description, :string
      add :company, :string
      add :url, :string
      add :twitter, :string
      add :email, :string
      add :apply, :string

      timestamps()
    end

  end
end
