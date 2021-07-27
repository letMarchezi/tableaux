Definitions.

ATOM         = [a-z]
CONNECTIVE   = -(>)|[&]|[!]|[|] 
WHITESPACE   = [\s\t\n\r]

Rules.

{ATOM}        : {token, {atom, TokenLine, to_atom(TokenChars)}}.
{CONNECTIVE}  : {token, {connective_atom(TokenChars), TokenLine,
connective_atom(TokenChars)}}.
\(            : {token, {'(',  TokenLine}}.
\)            : {token, {')',  TokenLine}}.
{WHITESPACE}+ : skip_token.

Erlang code.

to_atom(Chars) ->
    list_to_atom(Chars).

connective_atom([$&|_]) ->
    'and';
    
connective_atom([$!|_]) ->
    'not';

connective_atom([$||_]) ->
    'or';
    
 connective_atom([$-,$>|_]) ->
    'implies'. 
