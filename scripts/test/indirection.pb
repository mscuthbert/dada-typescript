// MSAC: what can be an indirection in C/Yacc vs Typescript?

S: @animal "\n" @"cow" "\n" @param-animal(animal) "\n" ?an=@animal $an>add-ey
    // this line does not work in C. TypeScript take spaces and substitutes "-" first
    // so that @"Johann Strauss">make-works and @"Richard Strauss">make-works can still
    // function
     "\n" @"cucu bird";

animal: "cow" | "chick";
param-animal(ani): ani;

cow: "moo";
chick: "peep";
cucu-bird: "coocoo!";

// this fails, assuming that the "add-ey" applies before @:
//    @animal>add-ey
// it fails silently on C/Yacc
// and on Typescript with error "Indirection resolved to unknown rule: cowey"
// use (@animal)>add-ey;

add-ey:
   ".*$" -> "$"/"ey"
;
