/*
 *  A sample file that uses every syntax we support -- made by MSAC 2025 for typescript
 */

// ensuring that resource rules are not before others.
%resource animal: "cat" | "dog" | "fish";


story: TITLE(title) introduction named sentence "A " sentence>strip_the
       noise opposite-sentence weather-sentence parametric-sentence PBRK parade friends PBRK conclusion;

// testing silence and lazy set; note that main-animal<<animal>upcase-first is parsed as
// main-animal<<(animal>upcase-first) which isn't what is wanted here.  Hence the silence
// (this part of grammar isn't discussed in the spec nor included in any sample files.
title: ?punct=punctuation "The " ?main-animal<<animal $main-animal>upcase-first $punct BRK | title>upcase;
introduction: "A story about " ?main-animal<<animal $main-animal>pluralize "." BRK;  // testing main-animal not overwritten.
sentence: "The " double(animal) " run " [ "fast" | "sl" ["o" | "oooo"] "w"] "." BRK;
double(wrd): wrd " and another " wrd;
conclusion: "That's my story about a " $main-animal "." BRK;  // testing retrieval
punctuation: "!" | "" | "?";
noise: "I heard a " $main-animal>sound "." BRK;
sound:
    "fish" -> "gurgle"
    "dog" -> "bark"
    "cat" -> "meow"
;
opposite-sentence: "It was like " opp-word=opposite-word " and " $opp-word>opposites ". ";
opposite-word: "night" | "day" | "left" | "right";
opposites:
    "night" <-> "day"
    "left" <-> "right"
;

weather-sentence: "And it was " "very "* ["hot" | "cold"] "." BRK;

parametric-sentence: "Another " parametric-sentence2(animal) " showed up" punctuation BRK;
parametric-sentence2(ani): ani | ani " and another " [ ani | cat ];  // parameters in inline choices

// indirection tests
named: named1 "\n" named2 "\n";
named1: "My " $main-animal>upcase " is named " @$main-animal ". " BRK;
named2: "Its friend, a " local-animal=animal ", is named " @$local-animal " (never " @animal "). " PBRK;

dog: "Fido" | "Spot";
cat: "Morris" | "Princess";
fish: "Blubber" | "Flounder";

other_animal: animal | animal | "horse" | "giraffe" | "boar" | "zebra" | "wombat";

parade: "There was a parade led by:" BRK { i=1 } parade2 parade2;
parade2: parade3 | parade3 parade2;
parade3: $i ". " {=2..20} " " other_animal>pluralize "." BRK {i += 1};

friends: "The " $main-animal " had "
    { num_friends = 2..4; fc = 1; word=["zero","one","two","three","four"][num_friends] } $word
    " friends: " friend-repeat>strip_comma "." BRK;
friend-repeat: %repeat(friend, num_friends);
friend: "(" $fc ") " other_animal ", " { fc++ };

strip_comma:
    ".*, $" -> ", $"/""
;

pluralize:
    "^fish$" -> "fish$"/"fishes"
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
