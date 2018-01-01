defmodule EgWeb.JobsController do
  use EgWeb, :controller

  alias Eg.Job
  alias Eg.Repo

  plug EgWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_job_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    jobs = Repo.all(Job)
    render conn, "index.html", jobs: jobs
  end

  def show(conn, %{"id" => job_id}) do
    job = Repo.get(Job, job_id)
    render conn, "show.html", job: job
  end

  def new(conn, _params) do
    changeset = Job.changeset(%Job{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"job" => job}) do
    changeset = conn.assigns.user
      |> Ecto.build_assoc(:jobs)
      |> Job.changeset(job)

    case Repo.insert(changeset) do
      {:ok, _job} ->
        conn
        |> put_flash(:info, "Job Created")
        |> redirect(to: jobs_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => job_id}) do
    job = Repo.get(Job, job_id)
    changeset = Job.changeset(job, %{})
    render conn, "edit.html", changeset: changeset, job: job
  end

  def update(conn, %{"id" => job_id, "job" => updated_job}) do
    old_job = Repo.get(Job, job_id)
    changeset = Job.changeset(old_job, updated_job)

    case Repo.update(changeset) do
      {:ok, _job} ->
        conn
        |> put_flash(:info, "Job Updated")
        |> redirect(to: jobs_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, job: old_job
    end
  end

  def delete(conn, %{"id" => job_id}) do
    Repo.get!(Job, job_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Job Deleted")
    |> redirect(to: jobs_path(conn, :index))
  end

  def check_job_owner(conn, _params) do
    %{params: %{"id" => job_id}} = conn

    if Repo.get(Job, job_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: jobs_path(conn, :index))
      |> halt()
    end
  end
end
