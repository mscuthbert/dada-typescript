// MSAC -- testing the operator order of Kleene symbols (+ / *) to match C/Yacc and Typescript
// Note that these

S: A "\n" B "\n" C "\n" D "\n" E "\n" F G;

// kleene can work on bare strings
A: "hi "+;

// this gives one or more "cow-boo " or "chick-boo " (independently chosen)
B: animal>add-boo+ " ";

// This parses incorrectly in C/Yacc (+ is ignored); so it is okay to have it not parse in
// Typescript or have it be the same as "animal>add-boo+" (in fact it gives an unexpected token Transform)
// C: animal+>add-boo " ";
C: "";

// indirection with plus? In C/Yacc does not return anything -- just a blank.
// (and what would @goo* mean anyhow!) In Javascript gives "Kleene token + cannot be used in this position"
// D: @goo+;
D: "";

goo: "gob";

// if D works then we'd need these (and theoretically an infinite number of gob+)
// but it doesn't work.
gob: "gobble ";
gobgob: "gobblegobble ";
gobgobgob: "gobblegobblegobble ";

animal: "cow" | "chick";

add-boo:
   ".*$" -> "$"/"-boo "
;

E: "This should appear 0 or more times.\n"*;

// assigns after calling 1 or more times.
F: var=animal+ " " $var;

// prints nothing, but assigns to potentially one or more times;
G: ?var="he"*;

// this does not work, phew!
// H: var+=animal;
