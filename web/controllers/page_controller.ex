defmodule Bgt.PageController do
  use Bgt.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
