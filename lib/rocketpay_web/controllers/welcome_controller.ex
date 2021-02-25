alias Rocketpay.Numbers, as: Num

defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  def index(connection, %{"filename" => filename}) do
    filename
    |> Num.sum_numbers_from_file()
    |> handle_response(connection)
  end

  defp handle_response({:ok, %{result: result}}, connection) do
    connection
    |> put_status(:ok)
    |> json(%{message: "Welcome to the RocketPay API, your sum is: #{result}"})
  end

  defp handle_response({:error, reason}, connection) do
    connection
    |> put_status(:bad_request)
    |> json(reason)
  end
end
