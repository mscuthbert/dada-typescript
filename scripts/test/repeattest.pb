// s3...s5 tests added by MSAC, not in original

S: s1 s2 s3 s4 s9;

s1: %repeat("blah",3);

s2: { foo=10/2 } %repeat("foo",foo);

s3: ?var="hi" %repeat($var, 2);

// parameterized repeat is okay.
s4: %repeat(p("bye"), 2);
p(name): name "!";

// apparently each side of equation takes in a single, non-code entry
// All below fail
// s5: %repeat("blah ", "3");
// s6: %repeat("blah " "blah", 2);
// s7: %repeat(c c, 2);
// c: "blech " | "blue ";
// s8: %repeat("!", {2..3});

// var must be referred to w/o $
// s9: {var=2} %repeat("hi", $var);
