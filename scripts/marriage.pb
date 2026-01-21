// a: set-vars %repeat([gerund-activity-phrase>upcase-first PBRK], 30);
// a: set-vars %repeat([take-phrase>upcase-first PBRK], 30);
// a: set-vars %repeat([clean-phrase>upcase-first PBRK], 30);

start: set-vars
       TITLE([{= max_point + 1 } " " title]) PBRK
       HUG_TOP(CENTER(ITALIC(dedication))) PBRK
       BODY
       %repeat(point, max_point)
       $point_num ". Be the first to say, I’m sorry.";

// non-printing variables we will need.
set-vars:
    { point_num = 1 }
    { max_point=6..14 }
    ?me=pronoun
    ?them=@$me>make_partner;

article:
    "^[aeiou]" -> "^"/"an "
    "^[^aeiou]" -> "^"/"a "
;

trim-space:
    ".* $" -> " $"/""
;

title: lead " " connector " " quality>article " " union;
lead:
    "Steps" | "Rules" | "Tips" | "Sayings"
    | "Principles" | "Secrets" | "Guidelines" | "Lessons"
    | "Habits" | "Truths" | "Keys" | "Wisdom"
    | "Notes" | "Foundations";

connector:
    "for" | "for" | "for" | "of" | "to";

quality:
    "Good" | "Long" | "Peaceful" | "Happy" | "Great"
    | "Thriving" | "Lasting" | "Resilient" | "Joyful"
    | "Strong" | "Healthy" | "Successful" | "Balanced"
    | "Harmonious" | "Flourishing";

union:
    "Marriage" | "Marriage" | "Marriage"
    | "Partnership" | "Life" | "Union"
    | "Relationship" | "Love"
    | "Life Together";

dedication: dedication2>anti-creep;
dedication2: "(" dedicated>upcase-first " " [$me>make_affectionate_youth "s" | @$me>adult-plural] " " gendered2 ".)";
dedicated: "for"| "for" | "dedicated to" | "tips for" | "written for";

// anti-creep -- remove "men who love boys" -- creepy!
anti-creep: " men.* boys" -> " boys"/" men";

gendered2:
    "who love " $them>make_affectionate_youth "s"
    | "and the " @$them>adult-plural " they " adore
;

point: @{= point_num === 5 ? "point5" : "point2"} PBRK { point_num += 1 };
point2: $point_num ". " sentence>upcase-first>trim-space;
// point 5 is always this.  (last point is always about saying sorry.
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
he-adult-plural: "men" | "guys";

adore: "adore" | "love" | "swore " ["a vow" | "vows"] " to";

possessive:
    "^she" -> "her"
    "^he" -> "his"
;
pronoun: "he" | "she";
he-partner: "she" | "she" | "she" | "he";
she-partner: "he" | "he" | "he" | "she";


// SENTENCES BEGIN HERE
sentence:
    prefix-opt verb-phrase optional-conditional-suffix punctuation;
    // "(" $noun-var "/" $noun-var2 ")";

prefix-opt: "" | "" | prefix-time;
prefix-time:
    "before " deadline ", "
    | "prior to " deadline ", "
    | "as soon as possible, "
    | "every hour, on the hour, "
    | "when the mood strikes, "
    | "occasionally ";
deadline: "midnight" | "next week" | "getting dressed";
punctuation: "." | "." | "." | "." | "." | "." | "." | "!";

verb-phrase:
    "play " noun-phrase(play-noun-var<<play-noun) optional-together
    | "make " make-noun-var<<make-noun optional-together
    | take-phrase
    | food-phrase
    | try-phrase
    | clean-phrase
    | "remember " memory>trim-space
    | watch-phrase
    | "drink " drink
    | "forgive that " $them " " partner-problems
    | "be " the-kind-of " " $me>make_affectionate_youth " that " $them " " fell-for
    | therapy-sentence
    | gerund-activity-phrase
    | gerund-activity-phrase
;

clean-phrase:
    restricted-clean-verb " " restricted-clean-thing optional-together
    | clean-verb " " clean-thing-out
    | purge " " purgeable-things;
// restricted things don't need an "out" or "up"
restricted-clean-verb: "clean" | "declutter";
restricted-clean-thing: "the house" | "the yard";
clean-verb:
    "clean out" | "straighten up"
;
clean-thing-out:
    "the garage"
    | restricted-clean-thing
    | "your secret box of memories of your exes"
    | [ "your" | $them>possessive ] " "
      optional-expensive " collection of " collection-thing
    | [ "your" | $them>possessive ] " "
      optional-expensive " pile of " collection-thing optional-together
;

purge:
    "throw out" | "purge"
    | "get rid of" | "ditch" | "clear out"
    | "finally part with" | "declutter" | "clean out"
;

purgeable-things:
    "everything in the closet"
    | "whatever you don’t need"
    | "all the old junk"
    | "the stuff that’s been collecting dust"
    | "those boxes in the garage"
    | "half your storage unit"
    | [ "your" | $them>possessive ] " "
      optional-expensive " collection of " collection-thing
    | [ "your" | $them>possessive ] " "
      optional-expensive " stash of " collection-thing
    | [ "your" | $them>possessive ] " "
      optional-expensive " pile of " collection-thing
;

optional-expensive: "" | expensive;
expensive:
    "vintage" | "treasured" | "expensive" | "antique"
    | "rare" | "prized" | "nostalgic"
    | "long-forgotten" | "dusty" | "sentimental"
;

collection-thing:
    "comic books" | "cosplay outfits" | "risqué postcards"
    | "old magazines" | "collector figurines" | "vinyl records"
    | "concert posters" | "souvenir mugs" | "Pokémon cards"
    | "photo albums" | "board games" | "retro gadgets"
    | "novelty T-shirts" | "American Girl dolls" | "random keepsakes"
    | "National Geographics"

    | "Otter Pops" | "vintage lunchboxes" | "action figures"
    | "model trains" | "snow globes" | "shot glasses"
    | "unused planners" | "half-finished sudoku"
    | "old phone chargers" | "mystery cables"
    | "participation ribbons"
    | "fridge poetry"
    | "decorative theme-park throw pillows"
;

watch-phrase:
    "watch “" watch-list "”" optional-together-or-with-others
;

noun-phrase(n): n | adjective " " n;

adjective: "old standby" | "new" | "quick" | "long" | "passionate" | adjective " " adjective;
generic-noun: play-noun | make-noun | food-noun;
play-noun: "piano" | "hookey" | "around" | scare-quote(play-noun);
make-noun:
    "movies"
    | "love"
    | "a " new " recipe"
    | "a " new " plan"
    | "a playlist"
    | "a garden bed"
    | "a photo album"
    | "a budget check-in"
    | "a calendar reset"
    | "a " new " tradition"
    | "a board game night"
    | "a date night"
    | scare-quote(make-noun);

new: "new" | "new" | "new" | "fresh";

take-phrase:
    take-verb " " take-activity>article optional-together-or-with-others optional-tone-hint
;
take-verb: "take" | "take" | "take" | "plan";
take-activity:
    take-activity-2
    | take-activity-2
    | take-activity-2
    | duration " " take-activity-2
    | when " " take-activity-2
    | fun-location " " take-activity-2
;

take-activity-2:
    "walk"
    | "walk"
    | "hike"
    | "date night" | "mini-adventure" | "day trip"
    | "getaway" | "museum visit" | "coffee run"
    | fun-location " day"
;
duration: "long" | "long" | "short" | "short" | "brief" | "monthly";
when: "sunrise" | "sunset" | "weekend" | "twilight" | "evening" | "after-dinner";
fun-location: "beach" | "mountain" | "pool" | "downtown";

optional-tone-hint:
    "" | "" | "" | " " tone-hint
;
tone-hint:
    "for fun"
    | "with no pressure"
    | "just to reconnect"
    | "to reset"
    | "to laugh a little"
;

food-phrase:
    food-verb " " food-noun optional-together
;

food-verb:
    "eat"
    | "cook"
    | "enjoy"
    | food-adverb " " food-verb
;
food-adverb:
    "slowly" | "sensually" | "eagerly"
;

food-noun:
    food-var<<food-kind " " food
    | food-var<<food-kind " " food
    | food-kind " " food
    | food-kind "-style " food
    | food-noun " " tone-hint  // take advantage of same rule cannot be chosen twice in succession
;

food-kind: "Japanese" | "Chinese" | "Mexican" | "Italian";
food: "food" | "food" | "cuisine";

the-kind-of: "the kind of" | "a type of " | "the " | "a ";
fell-for: "first fell for" | "goes gaga for" | ["always " | ""] "dreamt of";

scare-quote(scarything): "“" scarything "”";

watch-list: "Mad Men" | "Whose Line is it Anyway" | "Børgen" | "Succession" | "Severance" | "Top Chef";

optional-conditional-suffix: "" | "" | "" | " " conditional-suffix;
conditional-suffix:
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


// e.g. 'go bowling' / 'try hiking together'
gerund-activity-phrase:
    imperative-activity " " gerund-activity;

imperative-activity:
    direct-imperative-activity | garden-path-imperative-activity;

// these do not make sense to have "a little" after like "go a little bowling"
direct-imperative-activity:
    "go" | "go" | "start";

garden-path-imperative-activity:
    garden-path-imperative-activity-verb
    | garden-path-imperative-activity-verb
    | garden-path-imperative-activity-verb " " garden-path
;

garden-path-imperative-activity-verb:
    "try" | "learn" | "make time for";

garden-path:
    "a little " | "a bit of ";

gerund-activity:
    gerund-activity2 optional-together
;

gerund-activity2:
    "bowling" | "skiing" | "hiking"
    | "gardening" | "dancing"
    | "swimming" | "kayaking"
    | "snorkeling" | "running"
    | "cycling"
    | "climbing" | "camping"
    | "reading" | "journaling"
    | "volunteering" | "stargazing"
    | "birdwatching" | "picnicking"
    | "painting" | "scrapbooking"
    | "puzzling" | "board-gaming"
;


// not gerunds use elsewhere | "yoga" | "photography"

optional-together: "" | "" | " " together;
optional-together-or-with-others: "" | "" | " " together | " " with-others;
together:
    "together" | "together" | "as a " couple
    | "with each other" | "side by side" | "hand in hand"
    | "just the two of you" | "in sync"
;
couple:
    "couple" | "couple" | "pair" | "team"
;
with-others: "with friends" | "with some friends" | "with " $them>possessive " family";

// non-gerund things to do like "yoga" -- that you can't "go" - no "go photography" etc.
try-phrase:
    try " " try-activity optional-together
;
try:
    "try" | "try" | "start" | "take up" | "do"
;
try-activity:
    "yoga" | "photography" | "chores"
;

