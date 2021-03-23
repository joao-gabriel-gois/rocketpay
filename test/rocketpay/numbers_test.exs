defmodule Rocketpay.NumbersTest do
  use ExUnit.Case, async: true
  # ONLY TO SIMULATE UNIT TESTS
  alias Rocketpay.Numbers, as: Num

  describe "sum_numbers_from_file/1" do
    test "when there is a csv file with the given name, returns the sum of numbers" do
      response = Num.sum_numbers_from_file("numbers")

      expected_response = {:ok, %{result: 37}}

      assert response == expected_response
    end

    test "when there is no csv file with the given name, returns the one error" do
      response = Num.sum_numbers_from_file("numb")

      expected_response = {:error, %{message: "Invalid File!!"}}

      assert response == expected_response
    end
  end
end
