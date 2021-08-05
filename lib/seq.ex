defmodule AnalyticTableaux do
  @moduledoc """
  Documentation for `Seq`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Seq.hello()
      :world

  """
  
  @spec parse(binary) :: list
  def parse(str) do
    {:ok, tokens, _} = str |> to_charlist() |> :lexer.string()
    {:ok, list} = :parser.parse(tokens)
    list
  end

  def hello do
    IO.puts("Hello World!")
  end
end
