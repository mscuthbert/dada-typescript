/*
 *  A sample file that uses every syntax we support.
 */

story: title introduction sentence "A " sentence>strip_the noise opposite-sentence conclusion;
title: ?punct=punctuation "The " main-animal<<animal $punct "\n";  // testing silence and lazy set
introduction: "A story about " main-animal<<animal "s.\n";  // testing main-animal not overwritten.
sentence: "The " double(animal) " run " [ "fast" | "sl" ["o" | "oooo"] "w"] ". ";
animal: "cat" | "dog" | "fish";
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

trim_e:
        ".*e$" -> "e$"/""
;

strip_the:
        ".*" -> "^[Tt]he "/""
;
