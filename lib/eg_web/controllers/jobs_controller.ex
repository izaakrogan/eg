defmodule EgWeb.JobsController do
  use EgWeb, :controller

  alias Eg.Job
  alias Eg.Repo

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
    IO.puts("hello")
    changeset = Job.changeset(%Job{}, job)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
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
end
