story: title sentence sentence>strip_the;
title: "My title. ";
sentence: "The " animal " runs fast. ";
animal: "cat" | "dog" | "fish";

trim_e:
        ".*e$" -> "e$"/""
;

strip_the:
        ".*" -> "^[Tt]he "/""
;
