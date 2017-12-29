defmodule EgWeb.Router do
  use EgWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EgWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EgWeb do
    pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
    resources "/", JobsController

    # jobs_path  GET     /                         EgWeb.JobsController :index
    # jobs_path  GET     /:id/edit                 EgWeb.JobsController :edit
    # jobs_path  GET     /new                      EgWeb.JobsController :new
    # jobs_path  GET     /:id                      EgWeb.JobsController :show
    # jobs_path  POST    /                         EgWeb.JobsController :create
    # jobs_path  PATCH   /:id                      EgWeb.JobsController :update
    #            PUT     /:id                      EgWeb.JobsController :update
    # jobs_path  DELETE  /:id                      EgWeb.JobsController :delete
  end

  scope "/auth", EgWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    # request is defined by Ueberauth
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

end
