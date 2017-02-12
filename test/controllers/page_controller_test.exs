defmodule Bgt.PageControllerTest do
  use Bgt.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "bgt"
  end
end
