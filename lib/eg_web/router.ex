defmodule EgWeb.Router do
  use EgWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EgWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    resources "/users", UserController

    # Resources produces the following:

    # user_path  GET     /users             EgWeb.UserController :index
    # user_path  GET     /users/:id/edit    EgWeb.UserController :edit
    # user_path  GET     /users/new         EgWeb.UserController :new
    # user_path  GET     /users/:id         EgWeb.UserController :show
    # user_path  POST    /users             EgWeb.UserController :create
    # user_path  PATCH   /users/:id         EgWeb.UserController :update
    #            PUT     /users/:id         EgWeb.UserController :update
    # user_path  DELETE  /users/:id         EgWeb.UserController :delete

    # to generate only some of the available restful routes, use 'only'
    resources "/posts", PostController, only: [:index, :show]

    # post_path  GET     /posts             EgWeb.PostController :index
    # post_path  GET     /posts/:id         EgWeb.PostController :show

    # to exclude some of the available restful routes, use 'except'
    resources "/comments", CommentController, except: [:index, :edit, :new, :delete, :update]

    # comment_path  GET     /comments/:id      EgWeb.CommentController :show
    # comment_path  POST    /comments          EgWeb.CommentController :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", EgWeb do
  #   pipe_through :api
  # end


  # The Phoenix.Router.forward/4 macro can be used to send all requests that start
  # with a particular path to a particular plug. Let’s say we have a part of our
  # system that is responsible (it could even be a separate application or library)
  #  for running jobs in the background, it could have its own web interface for
  #  checking the status of the jobs. We can forward to this admin interface using:
  forward "/jobs", BackgroundJob.Plug

  scope "/" do
    pipe_through [:authenticate_user, :ensure_admin]
    forward "/jobs", BackgroundJob.Plug
  end

end
