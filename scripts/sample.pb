/*
 *  A sample file that uses every syntax we support -- made by MSAC 2025 for typescript
 */

// ensuring that resource rules are not before others.
%resource animal: "cat" | "dog" | "fish";


story: title introduction named sentence "A " sentence>strip_the
       noise opposite-sentence parametric-sentence parade conclusion;

// testing silence and lazy set; note that main-animal<<animal>upcase-first is parsed as
// main-animal<<(animal>upcase-first) which isn't what is wanted here.  Hence the silence
// (this part of grammar isn't discussed in the spec nor included in any sample files.
title: ?punct=punctuation "The " ?main-animal<<animal $main-animal>upcase-first $punct "\n";
introduction: "A story about " main-animal<<animal "s.\n";  // testing main-animal not overwritten.
sentence: "The " double(animal) " run " [ "fast" | "sl" ["o" | "oooo"] "w"] ". ";
double(wrd): wrd " and " wrd;
conclusion: "\nThat's my story about a " $main-animal ".";  // testing retrieval
punctuation: "!" | "" | "?";
noise: "\nI heard a " $main-animal>sound ".";
sound:
    "fish" -> "gurgle"
    "dog" -> "bark"
    "cat" -> "meow"
;
opposite-sentence: "\nIt was like " opp-word=opposite-word " and " $opp-word>opposites ".";
opposite-word: "night" | "day" | "hot" | "cold";
opposites:
    "night" <-> "day"
    "hot" <-> "cold"
;

parametric-sentence: "\nAnother " parametric-sentence2(animal) punctuation "\n";
parametric-sentence2(ani): ani | ani " and " [ ani | cat ];  // parameters in inline choices

// indirection tests
named: named1 "\n" named2 "\n";
named1: "My " $main-animal>upcase " is named " @$main-animal ". ";
named2: "Its friend, a " local-animal=animal ", is named " @$local-animal " (never " @animal "). ";

dog: "Fido" | "Spot";
cat: "Morris" | "Princess";
fish: "Blubber" | "Flounder";

other_animal: animal | animal | "horse" | "giraffe" | "boar" | "zebra" | "wombat";

parade: "In the parade there were:\n" { i=1 } parade2 parade2;
parade2: parade3 | parade3 parade2;
parade3: $i ". " {=2..20} " " other_animal>pluralize ".\n" {i += 1};

pluralize:
    "fish$" -> "fish$"/"fishes"
	".*y$" -> "y$"/"ies"
	".*s$" -> "$"/"es"
	".*" -> "$"/"s"
;

trim_e:
        ".*e$" -> "e$"/""
;

strip_the:
        ".*" -> "^[Tt]he "/""
;
