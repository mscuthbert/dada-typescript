start: { point_num = 1 } { max_point=6..14 } ?me=pronoun ?them=@$me>make_partner
       TITLE([{= max_point + 1 } " " title]) PBRK
       HUG_TOP(CENTER(ITALIC(gendered))) PBRK
       BODY
       %repeat(point, max_point)
       $point_num ". Be the first to say, I’m sorry.";

title: steps " for a " good " " marriage;
steps: "Steps" | "Rules" | "Tips" | "Sayings";
good: "Good" | "Long" | "Peaceful" | "Happy" | "Great";
marriage: "Marriage" | "Marriage" | "Partnership" | "Life";

gendered: "(" dedicated>upcase-first " " [$me>make_affectionate_youth "s" | @$me>adult-plural] " " gendered2 ".)";
dedicated: "for"| "for" | "dedicated to" | "tips for" | "written for";

gendered2:
    "who love " $them>make_affectionate_youth "s"
    | "and the " @$them>adult-plural " they " adore
;


point: @{= point_num === 5 ? "point5" : "point2"} PBRK { point_num += 1 };
point2: $point_num ". " sentence>upcase-first>trim-space;

point5: "5. Laugh ... often!";

make_partner:
    ".*" -> "$"/"-partner"
;

make_affectionate_youth:
    "^she$" -> "girl"
    "^he$" -> "boy"
;

adult-plural: ".*" -> "$"/"-adult-plural";

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


// SENTENCES BEGIN HERE
sentence: prefix-opt verb-phrase optional-suffix punctuation; // "(" $noun-var "/" $noun-var2 ")";
punctuation: "." | "." | "." | "." | "." | "." | "." | "!";
prefix-opt: "" | "" | prefix;
prefix:
    "before " deadline ", "
    | "prior to " deadline ", "
    | "as soon as possible, "
    | "every hour, on the hour, "
    | "occasionally ";
deadline: "midnight" | "next week" | "waking up";

verb-phrase:
    "play " noun-phrase(play-noun)
    | "make " noun-phrase(make-noun)
    | "eat " food-phrase
    | "cook " food-phrase ["" | "" | "" | " together"]
    | clean-phrase
    | "remember " memory>trim-space
    | "watch “" watch-list "”"
    | "drink " drink
    | "forgive that " $them " " partner-problems
    | "be " the-kind-of " " $me>make_affectionate_youth " that " $them " " fell-for
    | therapy-sentence
    | "go bowling";

clean-phrase: "clean " clean-thing;
clean-thing: "the house" | "the yard" | "out your secret box of memories of your exes";

noun-phrase(n): noun-phrase1(n) | noun-phrase2(n);
// older phrase
noun-phrase1(n): noun-var<<n | adjective " " noun-var<<n | adjective " " noun-var<<n;
// newer phrase
noun-phrase2(n): noun-var2<<n | adjective " " noun-var2<<n | adjective " " noun-var2<<n;

adjective: "old standby" | "new" | "quick" | "long" | "passionate" | adjective " " adjective;
generic-noun: play-noun | make-noun | food-phrase;
play-noun: "piano" | "hookey" | "around" | scare-quote(play-noun);
make-noun: "movies" | "love" | "a new plan together"| scare-quote(make-noun);

food-phrase: food-var<<food-kind " food" | food-var<<food-kind " cuisine" | food-kind " food";
food-kind: "Japanese" | "Chinese" | "Mexican" | "Italian";

the-kind-of: "the kind of" | "a type of " | "the " | "a ";
fell-for: "first fell for" | "goes gaga for" | ["always " | ""] "dreamt of";

scare-quote(scarything): "“" scarything "”";

watch-list: "Mad Men" | "Whose Line is it Anyway" | "Børgen" | "Succession" | "Severance" | "Top Chef";

optional-suffix: "" | "" | " " suffix;
suffix:
    "if " pronoun-re " " in-the-mood
    | "when " pronoun-re " " in-the-mood
    | "unless " partner-problem-phrase-1
    | "wherever " partner-problem-phrase-1
    | "since " partner-problem-phrase-1
    | "unless " ["your" | $them>possessive] " work " sucks
    | "until " until
    | "unless we are " tired-of " " [noun-var<<generic-noun | noun-var2<<generic-noun];

pronoun-re: "we’re" | $them "’s" | $them "’s" | "you’re";
in-the-mood: "in the mood" | "feeling up for it" | "affirmed";

partner-problem-phrase-1:
    $them " " partner-problems;
sucks: "sucks" | "is stressful" | "needs addressing first";

partner-problems: "works " excessive  | specific-problems " " excessive | self-neglect;
specific-problems: "smokes" | "drinks" | "shouts";
until: "we’re exhausted" | "we can’t move on" | "2am";
excessive: "too much" | "excessively" | "like a narcissist";
self-neglect:
    ignores " " optional-flattery $me>make_affectionate_youth "s" [ "" | " like you"];
ignores: "ignores" | "is too busy to appreciate";
optional-flattery: "" | "" | "beautiful " | "amazing " | "cute " | "brilliant ";

drink:
    "scotch" | "whiskey" | "champagne" | "bubby" | "rum"
    | "chocolate milk" | "fizzy water"
    | "something that makes you remember " memory;
memory: "your first " nice-thing | $them>possessive " best qualities ";
nice-thing: "date" | "kiss";

therapy-sentence: get " " therapy " for " [ "your" | $them>possessive | $them>possessive ] " " problems;
get: "get" | "seek" | "ask for";
therapy: "therapy" | "counseling" | "help";
problems: "narcissism" | "insecurity" | "problems" | "current situation";

tired-of: "sick of" | "tired of" | "over";
