defmodule OpenmaizePhoenixBoilerplate.PageController do
  use OpenmaizePhoenixBoilerplate.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
