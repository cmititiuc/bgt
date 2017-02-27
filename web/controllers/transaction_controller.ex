defmodule Bgt.TransactionController do
  use Bgt.Web, :controller

  alias Bgt.Transaction

  import Bgt.Authorize
  import Ecto.Query

  plug :user_check

  def index(conn, _params) do
    %{assigns: %{current_user: %{id: id}}} = user_check(conn, %{})
    changeset = Transaction.changeset(%Transaction{})
    transactions = get_transactions(id)
    render(conn, "index.html", transactions: transactions, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Transaction.changeset(%Transaction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    %{assigns: %{current_user: %{id: id}}} = user_check(conn, %{})
    changeset = Transaction.changeset(%Transaction{user_id: id}, transaction_params)

    case Repo.insert(changeset) do
      {:ok, _transaction} ->
        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: transaction_path(conn, :index))
      {:error, changeset} ->
        transactions = get_transactions(id)
        render(conn, "index.html", transactions: transactions, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    %{assigns: %{current_user: %{id: current_user_id}}} = user_check(conn, %{})
    transaction = Repo.one!(
      from t in Transaction, where: [user_id: ^current_user_id, id: ^id]
    )
    render(conn, "show.html", transaction: transaction)
  end

  def edit(conn, %{"id" => id}) do
    %{assigns: %{current_user: %{id: current_user_id}}} = user_check(conn, %{})
    transaction = Repo.one!(
      from t in Transaction, where: [user_id: ^current_user_id, id: ^id]
    )
    changeset = Transaction.changeset(transaction)
    render(conn, "edit.html", transaction: transaction, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    %{assigns: %{current_user: %{id: current_user_id}}} = user_check(conn, %{})
    transaction = Repo.one!(
      from t in Transaction, where: [user_id: ^current_user_id, id: ^id]
    )
    changeset = Transaction.changeset(transaction, transaction_params)

    case Repo.update(changeset) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction updated successfully.")
        |> redirect(to: transaction_path(conn, :show, transaction))
      {:error, changeset} ->
        render(conn, "edit.html", transaction: transaction, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    %{assigns: %{current_user: %{id: current_user_id}}} = user_check(conn, %{})
    transaction = Repo.one!(
      from t in Transaction, where: [user_id: ^current_user_id, id: ^id]
    )

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(transaction)

    conn
    |> put_flash(:info, "Transaction deleted successfully.")
    |> redirect(to: transaction_path(conn, :index))
  end

  defp get_transactions(id) do
    Repo.all(
      from t in Transaction,
      where: t.user_id == ^id,
      order_by: [desc: :inserted_at]
    )
    |> Enum.group_by(fn (t) ->
      t.inserted_at
      |> Timex.Timezone.convert(Timex.Timezone.get("America/New_York", Timex.now))
      |> Timex.to_date
    end)
    |> Enum.to_list
    |> Enum.sort(fn({date_a, _}, {date_b, _}) ->
      Timex.compare(date_a, date_b) == 1
    end)
  end
end
