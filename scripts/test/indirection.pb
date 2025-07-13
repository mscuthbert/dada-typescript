// MSAC: what can be an indirection in C/Yacc vs Typescript?  All of these work on both systems

S: @animal "\n" @"cow" "\n" @param-animal(animal) "\n" ?an=@animal $an>add-ey
     "\n" @"cucu bird";  // this line does not work in C.

animal: "cow" | "chick";
param-animal(ani): ani;

cow: "moo";
chick: "peep";
cucu-bird: "coocoo!";

// this fails, assuming that the "add-ey" applies before @:
//    @animal>add-ey
// it fails silently on C/Yacc
// and on Typescript with error "Indirection resolved to unknown rule: cowey"

add-ey:
   ".*$" -> "$"/"ey"
;
