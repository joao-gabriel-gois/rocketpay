defmodule Rocketpay.Numbers do
  def sum_numbers_from_file(filename) do
    # = operand operates by pattern matching
    # file = File.read("#{filename}.csv")
    # handle_file(file)
    # ABOVE COMMENTED CODE COULD BE DONE WITH PIPE OPERATOR, AS BELOW:
    "#{filename}.csv"
    |> File.read()
    |> handle_file()
    # In summary, it will get the return of previous line and use as 1st argument of the next line's function
  end
  # Bellow we have one example of pattern matching (used in fucntions)
  defp handle_file({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Stream.map(fn number -> String.to_integer(number) end) # Stream apply enum methods but "iterates" only once here
      |> Enum.sum() # and here

    {:ok, %{result: result} }
  end # In case pattern matches here, execute this one
  defp handle_file({:error, _reason}), do: {:error, %{message: "Invalid File!!"}} # Else if, execute this one
  # If we don't use 2 elements tuple inside handle_file function it will not match
end
