defmodule Bgt.PageControllerTest do
  use Bgt.ConnCase

  import Bgt.TestHelpers

  defp log_in(conn) do
    user_attrs = %{username: "robin", password: "mangoes&g0oseberries"}
    post conn, session_path(conn, :create), session: user_attrs
  end

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn, 302) == "/sessions/new"
  end

  test "GET / when logged in", %{conn: conn} do
    conn = conn |> bypass_through(Bgt.Router, :browser) |> get("/")
    add_user("robin")
    conn = conn |> log_in |> get("/")
    assert html_response(conn, 200) =~ "Log Out"
  end
end
