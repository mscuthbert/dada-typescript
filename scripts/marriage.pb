start: TITLE(["10 " title]) PBRK ?me=pronoun ?them=@$me>make_partner CENTER(ITALIC(gendered)) PBRK BODY body;

title: steps " for a " good " " marriage;
steps: "Steps" | "Rules";
good: "Good" | "Long" | "Peaceful" | "Happy" | "Great";
marriage: "Marriage" | "Marriage" | "Partnership" | "Life";

gendered: "(For " [$me>make_affectionate_child "s" | make_adult_pl($me)] " " gendered2 ".)";

gendered2:
    "who love " $them>make_affectionate_child "s"
    | "and the " make_adult_pl($them) " they " adore
;

body: "1. " line PBRK
      "2. " line PBRK
      "3. " line PBRK
      "4. " line PBRK
      "5. Laugh...often." PBRK
      "6. " line PBRK
      "7. " line PBRK
      "8. " line PBRK
      "9. " line PBRK
      "10. Be the first to say, I’m sorry.";

line: sentence>upcase-first>trim-space;

make_partner:
    ".*" -> "$"/"-partner"
;

make_affectionate_child:
    "^she$" -> "girl"
    "^he$" -> "boy"
;

adlt: ".*" -> "$"/"-adult-plural";

make_adult_pl(pronoun): @pronoun>adlt;

she-adult-plural: "women" | "ladies";
he-adult-plural: "men";

adore: "adore" | "love" | "swore " ["a vow" | "vows"] " to";


possessive:
    "^she" -> "her"
    "^he" -> "his"
;


trim-space:
    ".* $" -> " $"/""
;

pronoun: "he" | "she";
he-partner: "she" | "she" | "she" | "he";
she-partner: "he" | "he" | "he" | "she";

sentence: prefix-opt verb-phrase optional-suffix punctuation;
punctuation: "." | "." | "." | "." | "." | "." | "." | "!";
prefix-opt: "" | "" | prefix;
prefix: "before midnight, " | "as soon as possible, " | "every hour, on the hour, " | "occasionally ";
verb-phrase:
    verb " " noun-phrase
    | verb " " noun-phrase
    | verb " " noun-phrase
    | verb " " noun-phrase
    | verb " " noun-phrase
    | "watch " watch-list
    | "drink " drink
    | "be the kind of " $me>make_affectionate_child " that " $them " first fell for"
    | "go bowling";
verb:  "play" | "eat" | "make" | "cook" | "clean";
noun-phrase: noun-phrase1 | noun-phrase2;
// older
noun-phrase1: noun-var<<noun | adjective " " noun-var<<noun | adjective " " noun-var<<noun;
//newer
noun-phrase2: noun-var2<<noun | adjective " " noun-var2<<noun | adjective " " noun-var2<<noun;

adjective: "old standby" | "new" | "quick" | "long" | "passionate" | adjective " " adjective;
noun: "movies" | "piano" | food-kind " food" | "love" | scare-quote(noun);
food-kind: "Japanese" | "Chinese" | "Mexican" | "Italian";

scare-quote(scarything): "“" scarything "”";

watch-list: "Mad Men" | "Whose Line is it Anyway" | "Børgen";

optional-suffix: "" | "" | " " suffix;
suffix: "if we're in the mood" | "unless " $them " " partner-problems | "since " $them " " partner-problems |
    "unless " ["your" | $them>possessive] " work sucks" | "until " until | "unless we are sick of " noun-var<<noun;
partner-problems: "programs " excessive  | "smokes " excessive | "ignores beautiful " $me>make_affectionate_child "s";
until: "we're exhausted" | "we destroy it" | "2am";
excessive: "too much" | "excessively" | "like a jerk";
drink: "scotch" | "rum" | "chocolate milk" | "fizzy water";
