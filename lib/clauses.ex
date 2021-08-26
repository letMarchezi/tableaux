defmodule Clauses do
  @moduledoc """
  Documentation for `clauses`.
  """
  @doc """
  ## Examples

    Clauses.parse_formula("a->b,b->c,c->d|-d")
    iex>
    [
      %Clauses{formula: {:implies, :a, :b}, sign: T},
      %Clauses{formula: {:implies, :b, :c}, sign: T},
      %Clauses{formula: {:implies, :c, :d}, sign: T},
      %Clauses{formula: :d, sign: F}
    ]

  """
  defstruct sign: T, formula: nil
  
  @spec parse(binary) :: list
  def parse(str) do
    {:ok, tokens, _} = str |> to_charlist() |> :lexer.string() # |> IO.inspect()
    {:ok, list} = :parser.parse(tokens)
    list
  end
  
  defp splitConclusion(str), do: String.split(str, "|-")
  
  defp splitPremise([head | tail]) do
    [ String.split(head, ",") | tail ] 
  end

  defp termsToAtom([head | tail]) do 
    Enum.map(head, fn h -> Clauses.parse(h) end) 
    ++ Enum.map(tail, fn t -> Clauses.parse(t) end)     
  end

  defp signedFormula([head | [] ]), do: [%Clauses{sign: F, formula: head}]
  defp signedFormula([head | tail]) do
    [%Clauses{formula: head} | signedFormula(tail)]
  end

  def parse_formula(str) do
    str 
    |> splitConclusion() 
    |> splitPremise() 
    |> termsToAtom() 
    |> signedFormula()
    |> Tree.formulaToTree()
  end  
end






















