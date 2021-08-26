defmodule Solver do
  @moduledoc """
  Documentation for `Solver`.
  """

  @doc """
  solver
  ## Examples


  """
  

  def prover(str) do
    str |> Clauses.parse_formula() |> Tree.solvingTree() 
  end
end
