defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, it should return an user" do
      params = %{
        name: "João",
        password: "123456",
        nickname: "Pudou",
        email: "jg@test.com",
        age: 27,
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "João", age: 27, id: ^user_id} = user
    end


    test "when there are any invalid param, it should return an error" do
      params = %{
        name: "João",
        nickname: "Pudou",
        email: "jg@test.com",
        age: 15,
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
