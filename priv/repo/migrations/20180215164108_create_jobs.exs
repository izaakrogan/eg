defmodule Eg.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :title, :string
      add :company, :string
      add :salary, :integer

      timestamps()
    end

  end
end
