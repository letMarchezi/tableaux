Nonterminals elem.
Terminals 'not' 'and' 'or' 'implies' '(' ')' atom.
Rootsymbol elem.

Left 100 'implies'.
Left 200 'or'.
Left 300 'and'.
Unary 400 'not'.

elem -> '(' ')'             : {}.
elem -> '(' elem ')'        : '$2'.
elem -> atom                : extract_token('$1').               
elem -> elem 'implies' elem : {'implies', '$1', '$3'}.
elem -> elem 'or' elem      : {'or', '$1', '$3'}.
elem -> 'not' elem          : {'not', '$2'}.
elem -> elem 'and' elem     : {'and', '$1', '$3'}.

Erlang code.

extract_token({_Token, _Line, Value}) -> Value.
