// MSAC: what can be an indirection in C/Yacc vs Typescript?  All of these work on both systems

S: @animal "\n" @"cow" "\n" @param-animal(animal) "\n" ?an=@animal an>add-ey;

animal: "cow" | "chick";
param-animal(ani): ani;

cow: "moo";
chick: "peep";

// this fails silently on C/Yacc
// and on Typescript with error "Indirection resolved to unknown rule: cowey"
//    @animal>add-ey

add-ey:
   ".*$" -> "$"/"ey"
;
