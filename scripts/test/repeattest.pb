// f1,f2... tests and s3, s4... added by MSAC, original demonstrated s1, s2.

S: s1 s2 s3 s4 s5 s6 s7 s8 s9;

s1: %repeat("blah",3) "\n";

s2: { foo=10/2 } %repeat("foo",foo) "\n";

s3: ?var="hi" %repeat($var, 2) "\n";

// parameterized repeat is an atom apparently and okay.
s4: %repeat(p("bye"), 2) "\n";
p(name): name "!";

// atom can include a mapping.
s5: %repeat("hi">higher, 2) "\n";
higher:
   "hi" -> "high"
;

// repeat is itself an atom and okay.
s6: %repeat(%repeat("b",2), 2);

// setvar is an atom; empty string can also be repeated
s7: %repeat(ac="c",2) $ac %repeat(?ad="d",2);

// repeat can have Kleene star.
s8: %repeat("e",3)*;

// no crash. no print
s9: %repeat("f",0);

// apparently each side of equation takes in a single, non-code entry
// All below fail
// f1: %repeat("blah ", "3");
// f2: %repeat("blah " "blah", 2);
// f3: %repeat(c c, 2);
// c: "blech " | "blue ";
// f4: %repeat("!", {2..3});

// var must be referred to w/o $
// f5: {var=2} %repeat("hi", $var);
