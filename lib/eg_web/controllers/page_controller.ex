defmodule EgWeb.PageController do
  use EgWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
