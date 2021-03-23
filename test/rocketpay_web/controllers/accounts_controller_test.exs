defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "João",
        password: "123456",
        nickname: "Pudou",
        email: "jg@test.com",
        age: 27,
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic ZGVtb191c2VyOmRlbW9fcGFzc3dvcmQ=")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert  %{
        "account" => %{
          "balance" => "50.00",
          "id" => _id
        },
        "message" => "Balance updated successfully"
      } = response
    end

    test "when there is an invalid param, it should return an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "invalid param test"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => "Invalid deposit value! It must be a decimal."
      }

      assert response == expected_response

    end
  end
end
