defmodule Bgt.TransactionControllerTest do
  use Bgt.ConnCase

  alias Bgt.Transaction
  import Bgt.TestHelpers

  @valid_attrs %{amount: "120.5", description: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    conn = conn |> bypass_through(Bgt.Router, :browser) |> get("/")
    user = add_user("robin")

    {:ok, %{conn: log_in(conn), user: user}}
  end

  defp log_in(conn) do
    user_attrs = %{username: "robin", password: "mangoes&g0oseberries"}
    post conn, session_path(conn, :create), session: user_attrs
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, transaction_path(conn, :index)
    assert html_response(conn, 200) =~ "Date/Time"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, transaction_path(conn, :new)
    assert html_response(conn, 200) =~ "New transaction"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @valid_attrs
    assert redirected_to(conn) == transaction_path(conn, :index)
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @invalid_attrs
    assert html_response(conn, 200) =~ "Log Out"
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    transaction = Repo.insert! %Transaction{user_id: user.id}
    conn = get conn, transaction_path(conn, :show, transaction)
    assert html_response(conn, 200) =~ "Show transaction"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, transaction_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    transaction = Repo.insert! %Transaction{user_id: user.id}
    conn = get conn, transaction_path(conn, :edit, transaction)
    assert html_response(conn, 200) =~ "Edit transaction"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    transaction = Repo.insert! %Transaction{user_id: user.id}
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @valid_attrs
    assert redirected_to(conn) == transaction_path(conn, :show, transaction)
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid",
      %{conn: conn, user: user} do
    transaction = Repo.insert! %Transaction{user_id: user.id}
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit transaction"
  end

  test "deletes chosen resource", %{conn: conn, user: user} do
    transaction = Repo.insert! %Transaction{user_id: user.id}
    conn = delete conn, transaction_path(conn, :delete, transaction)
    assert redirected_to(conn) == transaction_path(conn, :index)
    refute Repo.get(Transaction, transaction.id)
  end
end
