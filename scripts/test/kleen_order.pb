// MSAC -- testing the operator order of Kleen symbols (+ / *) to match C/Yacc and Typescript

S: A "\n" B "\n" C "\n" D;

// kleen can work on bare strings
A: "hi "+;

// this gives one or more "cow-boo " or "chick-boo " (independently chosen)
B: animal>add-boo+ " ";

// This parses incorrectly in C/Yacc (+ is ignored); so it is okay to have it not parse in
// Typescript or have it be the same as "animal>add-boo+"
C: animal+>add-boo " ";

// indirection with plus? does not return anything -- just a blank.
// (and what would @goo* mean anyhow!)
D: @goo+;

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
