defmodule EgWeb.TestController do
  use EgWeb, :controller

  def index(conn, %{"atom" => atom}) do
    render conn, "index.html", atom: atom
  end
end
