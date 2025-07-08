story: title sentence sentence>strip_the;
title: "My title. ";
sentence: "The " double(animal) " run " [ "fast" | "sl" ["o" | "oooo"] "w"] ". ";
animal: "cat" | "dog" | "fish";
double(wrd): wrd " and " wrd;

trim_e:
        ".*e$" -> "e$"/""
;

strip_the:
        ".*" -> "^[Tt]he "/""
;
