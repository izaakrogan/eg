defmodule EgWeb.AuthController do
  use EgWeb, :controller
  plug Ueberauth

  alias Discuss.User

  def callback(conn, params) do
    
  end
end
