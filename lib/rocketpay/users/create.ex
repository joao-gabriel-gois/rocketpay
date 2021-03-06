defmodule Rocketpay.Users.Create do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo, User}

  def call(params) do
    Multi.new() # Multi operation
    |> Multi.insert(:create_user, User.changeset(params)) # name of the transaction now is create_account
    |> Multi.run(:create_account, fn repo, %{create_user: user} ->
      insert_account(repo, user)
    end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} ->
      preload_data(repo, user)
    end)
    |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_chageset()
    |> repo.insert()
      # Above pipe since user.id is the same as the call bellow:
      # repo.insert(account_changeset(user.id))
  end

  defp account_chageset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}

    Account.changeset(params)
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{preload_data: user}} -> {:ok, user} # if macthes with the name of transaction, twas a success case
    end
  end
end
