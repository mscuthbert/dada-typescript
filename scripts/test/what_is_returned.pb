// MSAC -- what is returned with multiple statements in a return clause

// this works on Typescript and returns the "first" clause. but crashes C/Yacc with
// syntax error, unexpected T_LITERAL, expecting T_IDENT or '='
TypeScript: {= "first"; "second" };

// this works on C/Yacc and returns the "first" clause!  Crashes TypeScript
CYacc: {= "first"; ="second" };
