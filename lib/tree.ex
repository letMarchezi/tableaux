defmodule Tree do
  defstruct [:value, left: nil, right: nil]
  
  def formulaToTree([head | []]) do 
    %Tree{value: head, right: nil, left: nil}
  end
  def formulaToTree([head | tail]) do 
    %Tree{value: head, right: nil, left: formulaToTree(tail)}
  end  

  # should return the result [:result => valid/invalid, %Tree{}=> answer]
  def solvingTree(tree), do: solvingTree(tree, tree, %Tree{}) 
  def solvingTree(current, tree, resolution) do
   
    IO.puts("1")
    newResult = updateResult(resolution, %Tree{value: current.value, left: nil, right: nil})
    IO.inspect(newResult, label: "Novo resultado:")
    
    cond do 
      closed?(current, tree) ->  [:valid, newResult]
    
      Rules.hasOperator?(current.value) -> addExpand(current.value, resolution) 

      leaf?(current) -> [:invalid, resolution]
      
      true ->  solvingTree(current.left, tree, newResult)
    end
  end
  
  def leaf?(tree) when is_atom(tree.value.formula), do: true
  def leaf?(%Tree{value: _, left: nil, right: nil}), do: true
  def leaf?(_), do: false

  # it looks for any contradiction in the tree
  def closed?(_, nil), do: false
  def closed?(current, tree) do 
    if contradiction?(current, tree) do 
      true
    else 
      closed?(current, tree.left)
    end
  end

  # extract the formula from both trees
  def contradiction?(%Tree{value: v1}, %Tree{value: v2}), do: contradiction?(v1, v2)
  def contradiction?(%Clauses{formula: f, sign: s1}, %Clauses{formula: f, sign: s2}) 
    when s1 != s2, do: true
  def contradiction?(_,_), do: false  


  # update the first result
  def updateResult(%Tree{value: nil, right: nil, left: nil} = tree, newResult) do 
    IO.inspect(tree, label: "folha")
    newResult
  end
  # reaches the leaf 
  def updateResult(%Tree{value: v, right: _, left: nil} = tree, newResult) do 
    IO.inspect(tree, label: "folha")
    %Tree{value: v, right: nil, left: newResult}
  end
  # traverse the tree
  def updateResult(%Tree{value: v, right: r, left: l} = tree, newResult) do
    IO.inspect(tree, label: "caule")
    %Tree{value: v, right: r, left: updateResult(l, newResult)}
  end



  def addExpand(current, %Tree{value: v, right: r, left: l}) when is_nil(r) and is_nil(l) do
   [ head | tail ] = Rules.expand(current)
   if Rules.branching?(current) do 
      %Tree{value: v, right: head, left: tail}
    else
      %Tree{value: v, right: r, left: head}
    end
  end 

  def addExpand(current, %Tree{value: v, right: r, left: l}), do: addExpand(current, l)

end
