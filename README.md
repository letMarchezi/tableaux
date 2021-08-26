# AnalyticTableaux
Proof procedure for propositional logic



## Clauses
parse_formula/1 receives a string and parse the formula into a tree

```elixir
Clauses.parse_formula("a, a->b, b->c |- c")

=> %Tree{
  left: %Tree{
    left: %Tree{
      left: %Tree{left: nil, right: nil, value: %Clauses{formula: :c, sign: F}},
      right: nil,
      value: %Clauses{formula: {:implies, :b, :c}, sign: T}
    },
    right: nil,
    value: %Clauses{formula: {:implies, :a, :b}, sign: T}
  },
  right: nil,
  value: %Clauses{formula: :a, sign: T}
}

```

## Rules
hasOperator?/1 returns true if the parameter isn't a atom.
branching?/1 returns true if the expression expansion creates a branch

## Tree
binary tree definition:
[:value, :left, :right]


