defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance updated successfully",
        account: %{
          id: account_id,
          balance: balance
        }
      }
  end

  def render("transaction.json", %{
      transaction: %TransactionResponse{
        to_account: %Account{
          id: to_id,
          balance: to_balance
        },
        from_account: %Account{
          id: from_id,
          balance: from_balance
        }}
    }) do
    %{
      message: "Transaction done successfully",
      transaction: %{
          from_account: %{
            id: from_id,
            balance: from_balance
          },
          to_account: %{
            id: to_id,
            balance: to_balance
          }
        }
      }
  end
end
