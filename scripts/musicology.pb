// Run "bin/dada musicology.pb"

// PB script for generating New Musicology Essays -- based on the Pomo script
// Updated, format-independent version
// Copyright (C) 1995, 1996 Andrew C. Bulhak
// Substantial modifications (C) 2006, 2011, 2018, 2025 Michael Scott Asato Cuthbert
// A paper generated from this was accepted to one of those bogus journals in 2018.

// The pomo.pb script includes this message:
// "this script is property of acb. You are permitted to use, modify and
//  distribute it as long as this notice is retained and any modifications
//  in distributed copies are clearly denoted."

// This version is therefore licensed under the same version: the modifications
// are property of MSAC, but wouldn't be possible without the work of acb.  You can
// continue to modify it as long as *this* notice is retained and any modifications
// in distributed copies are clearly noted.  Have fun!

// global variables used:
//  v-citable      name of artist (composer or writer) who is cited throughout text
//  v-first-author              last name of first author
//  v-subject, v-subject-2  a noun about which this rant is (i.e., a term)
//  v-subject-3      as above, but changes in each section
//  v-artist         name of a second artist cited throughout text possibly w/o works
//  v-composer -- might not be citable
//  v-person -- just someone (could even be generic) -- might change per

// uncomment test line to test things
// test: PROLOGUE sentence-about-existence EPILOGUE;
// test: PROLOGUE sentence-about-heroes-and-victims EPILOGUE;
// test: p1-concept-desc("modernism");
// test: p-three-term-title(ing-ing ing-ing ing-ing);
// test: insistence-on-thing("horse");
// test: artist>past-tensify;
// test: adj2 " " adj2 " " adj2 " " adj2 " " big-abst-thing;
// test: sent-about-big-neb-thing;
// test: sentence-containing-measure-numbers;
// test: sent-about-citable-and-dualism-2double(citable-artist dualisable-noun dualisable-adjective);
// test: doing-something-to-movement;
// test: sentence-about-self>upcase-first;
// test: conclusion-preamble;

// production rules start here
//
// rules with names preceded with p- are parametric versions of other rules;
// they accept parameters (usually for important elements)

// The first rule is the one that is run.

output: PROLOGUE TITLE(title>upcase-first) formatted-authors
  BODY sections PBRK summary EPILOGUE ;

title: title2>upcase-first | candid-title>upcase-first ": " title2>upcase-first ;

title2:
  v-subject<<new-term " in the works of " v-citable=citable-artist
  | v-subject<<new-term " in the works of " v-artist=artist
  | v-subject<<new-term " after " v-artist=artist
  | v-subject-2<<new-term " in the works of " v-citable=citable-artist
  | v-subject<<new-term " in the writings of " v-citable=citable-writer
  | v-subject<<new-term " in the music of " v-citable=citable-composer
  | v-subject<<new-term " in the music of " v-composer=composer
  | v-subject-2<<new-term " in the music of " v-citable=citable-composer

  | p-two-term-title(v-subject<<new-term v-subject-2<<new-term)
  | p-two-term-title(v-subject<<ideology v-subject-2<<new-term)
  | p-two-term-title(v-subject<<social-movement v-subject-2<<new-term)
  | p-three-term-title(v-subject<<social-movement v-subject2<<ideology new-term)
  | p-three-term-title(v-subject<<social-movement v-subject2<<ideology v-citable=citable-composer)
;

// use often when you need someone
person:
    v-citable<<citable-artist
    | v-composer<<composer
    | v-artist<<artist
    | v-person<<idea-source
    | idea-source
;


// a "foo and bar" title
p-two-term-title(foo bar):
    foo " " and-contra " " bar | bar " " and-contra " " foo ;

and-contra:
    "and" | "and" | contra
;

contra:
    "against" | "contra" | "without"
;

p-three-term-title(foo bar baz):
    foo ", " bar ", and " baz
    | foo ", " baz ", and " bar
    | bar ", " foo ", and " baz
    | bar ", " baz ", and " foo
    | baz ", " foo ", and " bar
    | baz ", " bar ", and " foo
;

candid-title:
    doing-something-to>upcase-first " " intellectual
    | adj>upcase-first " " abst-noun>pluralise>upcase-first
    | "The " concrete-adj>upcase-first " " concrete-noun>upcase-first
    | something-of-2>upcase-first " the " big-nebulous-thing>upcase-first
    | "The " something-of-2>upcase-first " of " big-thing>upcase-first
    | "The " big-nebulous-thing>upcase-first " of " something-of-2>upcase-first
    | big-nebulous-thing>pluralise>upcase-first " of " something-of-2>upcase-first
    | doing-something-to-movement>upcase-first " " social-movement>upcase-first

    // MSAC
    | concrete-adj>upcase-first " " concrete-noun>pluralise>upcase-first
    | foo=dualisable-word "/" $foo>opposite>upcase-first
    | p-three-term-title(ing-ing ing-ing ing-ing)
    | p-three-term-title(big-thing big-abst-thing big-abst-thing)
    | ing-ing " " big-abst-thing "/" ing-ing>upcase-first " " [big-thing | "ourselves"]
;

// from pomo but largely changed.
concrete-adj: "sounding" | "circular" | "silent" | "forgotten" | "fragmented"
  | "felt" | "cloistered" | "forbidden" | "sonic"
;

// symbolic-type objects
concrete-noun-gets-you-there: "door" | "window" | "key" | "bridge";

// from pomo mostly
concrete-noun: "door" | "window" | "key" | "sky" | "fruit" | "sea" | "tool";

// MSAC
ing-ing: doing-something-to | doing-something-to-movement | affective-verb>gerund;

doing-something-to-infinitives:
    "hear" | "deconstruct" | "feel" | "silence"
    | "sound" | "discipline" | "increase" | "instate" | "transpose"
    | "voice"
;

doing-something-to: doing-something-to-infinitives>gerund;


// alters social-movements
doing-something-to-movement-infinitives:
    "reinvent" | "deconstruct"
  | "reassess" | "decode" | "analyze"
;

doing-something-to-movement: doing-something-to-movement-infinitives>gerund;

// pomo
formatted-authors: authors ;

authors: authors author | author | author | author;
author: AUTHOR_INST(name [department ", " acad-institution]);

// department

department: "Department of " dept-topic | "School of " dept-topic;

dept-topic:
    "Music" | "Music" | "Musicology" | "Music Theory" | "Ethnomusicology" |
    "Music" | "Music" | "Musicology" | "Music Theory" | "Ethnomusicology" |
    "Visual and Performing Arts" | "Visual and Performing Arts" |
    "English" | "Literature" | "Dance" | "Art" |
    "Women’s Studies" | "African Studies" |
    "Sociolinguistics" | "Music Informatics" |
    "Sound Studies" | "Sonic Studies"
;

// institutions from whence authors come; mostly MSAC

acad-institution:
    "University of " university-of
    | "University of " university-of
    | something-university " University"
    | something-university " University"
    | something-college " College"
    | state-university " State University"
    | other-institution
;


// biased toward the big two
uc-schools:
     "Berkeley" | "Berkeley" | "Los Angeles" | "Los Angeles"
     | "Santa Barbara" | "San Diego" | "Riverside" | "Davis";

university-of:
    "Illinois" | "Georgia" | "Massachusetts, Amherst" |
    "California, " uc-schools | "California, " uc-schools |
    "Michigan" | "North Carolina, Chapel Hill" | "North Texas" | "Chicago" |
    "Hawai‘i"
;

something-university:
    "Oxford" | "Harvard" | "Cambridge" | "Yale" | "Indiana" |
    "Princeton" | "Columbia" | "Cornell" | "Grinnell" | "Brandeis" | "Tufts" | "Boston" |
    "The Ohio State"
;
something-college:
     "Smith" | "Mt. Holyoke" | "Kenyon" | "Dartmouth" | "Wellesley" | "Wesleyan"
;
state-university:
     "Portland" | "Penn" | "San Diego" | "Florida" | "Michigan" | "Humboldt" | "Chico" | "Oklahoma"
;

other-institution:
     "CUNY" | "M.I.T." | "Women’s Music Research Institute" | "The Juilliard School" | "Boston Conservatory"
;

sections: { num_sections=3..8 } %repeat(section, num_sections);

section: SECTION(section-title) PBRK paragraphs ;

section-title:
    term " and " v-subject-3=new-term
    | v-citable<<citable-artist " and " new-section-term
    | big-nebulous-thing>pluralise " of " something-of-2
    // MSAC
    | v-artist<<artist " re" neut-verb>past-tensify
;

// optionally clear v-subject-3 for the new term
new-section-term:
    term
    | v-subject-3=new-term
;

// stack the odds towards the creation of more text

paragraphs: intro-paragraph PBRK paragraphs-2 ;

paragraphs-2: paragraphs PBRK paragraph
  | paragraphs PBRK paragraph
  | paragraph PBRK paragraph
  | paragraph PBRK paragraph;

intro-paragraph:
    intro-sentence paragraph
    | intro-sentence paragraph
    | intro-sentence paragraph
    // MSAC
    | intro-sentence post-introduction-transition-sentence paragraph
;

// MSAC -- min 3-sentence paragraphs.
paragraph: paragraph sentence | sentence sentence sentence ;

sentence:
    sentence2>upcase-first
    | sentence2>upcase-first
    | sentence2>upcase-first
    | sentence2>upcase-first
    | sentence2>upcase-first
    | preamble>upcase-first sentence2
    | preamble>upcase-first sentence2
    | preamble>upcase-first sentence2
    | preamble>upcase-first sentence2
    // MSAC
    | "(" sentence2>trim_space>upcase-first ") "
    | question-sentence>upcase-first

;

sentence2:
    assumption " " implies-that result ". "
    | optional-transition v-person<<intellectual " uses the term “" term "” to denote " concept-desc ". "
    | justifier "we have to " choose " between " term " and " term ". "
    | sentence-main-theme-of  // expanded
    | v-person=intellectual " " promotes " the use of " term " to " imper-vp ". "
    | sentence-about-existence  // expanded
    | sentence-about-citable-artist(v-citable<<citable-artist)
    | "the " subject-object " is " neut-verb>past-tensify " into a " term>strip_the " that " p-includes-as(big-abst-thing) " " big-singular-thing ". "

    // MSAC new
    | p-sentence-choice-concept(term)
    | sentence-containing-measure-numbers
    | sent-about-big-neb-thing
    | sentence-about-self
    | sentence-about-heroes-and-victims
;

// sentences especially suited for introductions to paragraphs.

intro-sentence:
    intro-sentence2>upcase-first ;

intro-sentence2:
    "“" pseudo-quote>upcase-first ",” " says " " v-person=intellectual ". "
    | p-intro-sent-thing-state(big-thing state-of-being)
    | p-intro-sent-exhort-thing-author(big-thing citable-writer)
    | intro-sentence-choice
    | "In the works of " v-citable<<citable-artist
      ", " important-article " concept is " predominant-concept ". "
    | sentence-main-theme-of
;

sentence-main-theme-of:
    "the " main-theme-of " " work " is " concept-desc ". "
;

// MSAC
post-introduction-transition-sentence:
    post-introduction-transition-sentence-2>upcase-first " "
;

post-introduction-transition-sentence-2:
    the-or-this " idea has " optional-historical "precedent:"
    | "but what does this really " mean-signify "?"
    | "where can " we-one " " go-move " from here?"
    | "On one " point ", " person " was " right ":"
;

point:
    "thing"
    | "point"
;

right:
    "right"
    | "wrong"
;

go-move:
   "go" | "move"
;

mean-signify:
    "mean" | "signify" | "imply"
;

optional-historical:
    "" | "historical "
;

optional-transition:
    ""
    | "as an example, "
    | "for instance, "
    | "e.g., "
;

important-article:
   "an important"
   | "a primary"
   | "the most important"
   | "the prime"
;

p-includes-as(phrase):
    "includes " phrase " as a"
    | "subsumes " phrase " under a "
    | "merges " phrase " with a "
    | "encompasses " phrase " within a "
;

examines: "examines" | "investigates" | "confronts" | "grapples with";

faced-with: "faced with" | "confronted by" | "struck by" | "hit with" |
            "faced with" ;

choice: "choice" | "dilemma" | "choice" | "paradox";

choose: "choose" | "choose" | "decide" | "pick" ;

conclude-that:
    "conclude that"
    | "decide that"
;

p-intro-sent-thing-state(th st):
     p-intro-sent-thing-state-pomo(th st)
     | p-intro-sent-thing-state-msc(th st)
;

p-intro-sent-thing-state-pomo(th st):
    "“" th>upcase-first " is " st ",” " says " " intellectual
    "; " however "according to " foo=person footnote-cite($foo)
    ", it is not so much " th " that is " st ", but " rather " the " something-of " of "
    th ". "
;

intro-sentence-choice:
  p-if-one(examines term)>upcase-first " " faced-with " a " choice ": "
           p-either([accept-or-reject " " term]) conclude-that " " result ". "
;

p-if-one(verb obj):
    "if one " verb " " obj ", one is"
    | "when we " verb>trim_s " " obj ", we are"
    | "when the " role " " verb " " obj ", " she-or-he " is"
;

she-or-he:
   "she" | "she/he" | "he or she"
;

p-either(p-term):
    "either " p-term " or" optional-alternatively " "
    | "one can " p-term " or" optional-alternatively " one can "
    | "(a) " p-term ", or" optional-alternatively " (b) "
;

optional-alternatively:
    "" | alternatively-clause
;
alternatively-clause:
    ", alternatively,"
    | ", on the other hand,"
    | ", on the contrary,"
    | ", " adv ","
;

says:
    "says"
    | "says"
    | "writes"
    | says-rarer
;

says-rarer:
    "stresses"
    | "emphasizes"
    | "exhorts"
;

// from original pomo--pulled out to be more realistic
// Any number of ambiguities about neo-Schenkerian narrative exist.
sentence-about-existence:
    plural-numeric-adj " " abst-noun>pluralise abst-description " " exist
    optional-do-something-about-them
    ". "
;

optional-do-something-about-them:
    ""
    | ", and " each " " modal-verb>would_will " be " makes-statement-about>trim_s>past-tensify " " in-turn
    | ", " each " " foo=generic-surname " " makes-statement-about " " in-turn " " footnote-cite($foo)>trim_space
;

each:
    "each"
    | "every one"
    | "each of which"
;

in-turn:
    "in turn"
    | "individually"
    | "separately"
;

// Though Adorno famous stated that music is the creation of elitism,
//    recent work by Cuthbert[1] argues that it is not so much music, but...

p-intro-sent-thing-state-msc(th st):
     "Though " intellectual " "
     stated
     [ " that " th " is " st ", "
         | ", “" th " is " st ",” " ]
     author-work-preamble " "
     foo=generic-surname footnote-cite($foo)
     show " that in a " optional-very-real " way, " th " is not " st
     ", but it is " optional-instead " the " something-of " of " th " that is " st ". "
;

show:
    "show"
    | "demonstrate"
;

optional-very-real:
    "" | "" | "very real"
;

stated:
   "stated"
   | "famously stated"
   | "wrote"
   | "is known for believing"
;

author-work-preamble:
    "recent works by"
    | "the writings of"
    | "the " nuance-adjective " ideas of"
;

nuance-adjective:
    "nuanced"
    | "subtle"
    | "groundbreaking"
;

// MSAC:

p-intro-sent-exhort-thing-author(th au):
  "“We must " neg-or-impersonal-neg-verb
  " " th " " anticipate-phrase " "
  affective-verb
  " " th ".” So " wrote-word " "
  au
  optional-echo
  position-in-book " “" @au>make_cite "”"
  optional-concluding-ramble
  ". "
;

optional-echo:
  " " | " " | " " | " " | " " | " (echoing " idea-source ") "
  | "—paraphrasing " idea-source "—"
;

affective-verb:
    neut-verb
    | pos-verb
    | pos-neg-verb
;

neg-or-impersonal-neg-verb:
    neg-verb
    | imper-neg-verb
;

optional-concluding-ramble:
    ""
    | ""
    | " (the " idea-source "ist " overtones
      " of " the-or-this " " philosophy-statement
      " are " obvious-adj ")"
    | " (" not-confused " " new-term ")"
    | "—not to " say " we " should-nt " " try
;

// not that we should *
try:
   "try"
   | "attempt it"
   | promotes>trim_s " them"
   | "suppress those who do"
;

we-one:
   "we" | "one"
;

should-nt:
    "should" | "shouldn't"
;

not-confused:
    "not to be confused with"
    | "distinct from"
    | "separate from"
    | "in contrast to"
;

overtones:
    "overtones"
    | "influences"
    | "resonances"
    | "notions"
;

philosophy-statement:
    "statement"
    | "statement"
    | "philosophy"
    | "belief"
    | "outburst"
;

clear-obvious-adj:
    "clear"
    | obvious-adj;

obvious-adj:
    "unmistakable"
    | "obvious"
    | "plain"
    | "absurd"
    | "trivial"
;

anticipate-phrase:
    anticipate-opening
    | anticipate-opening " " begin-to
;

anticipate-opening:
    "before we"
    | "as a preamble, from whence we"
;

begin-to:
    "can"
    | "can begin to"
    | "might start to"
;

wrote-word:
    "wrote"
    | "wrote"
    | "argued"
    | "asserted"
    | "posited"
;

position-in-book:
    "at the beginning of"
    | "in the preface of"
    | "in concluding"
    | "in"
    | "in chapter " non-zero-digit " of"
    | "on page " non-zero-digit-or-space digit " of"
;

// the predominent concept of x is *
predominant-concept:
    "the distinction between " foo=dualisable-word " and " $foo>opposite
    | "the conception of " adj " " big-abst-thing
    | "the defining of " adj " " big-abst-thing
;

// pseudo-quotes; no terminating punctuation.
pseudo-quote:
    big-thing " is " state-of-being
;

// we'll be ontologically masturbating in relation to the works of various
// artists and "artists" a lot.....

sent-about-citable-and-dualism(this-artist dualism):
    sent-about-citable-and-dualism-2(this-artist dualism)
    | sent-about-citable-and-dualism-2(this-artist dualism)
    | sent-about-citable-and-dualism-2double(this-artist dualism dualisable-adjective)
;

// Einstein on the Beach enforces masculinity where Contrary motion asserts femininity
//   50/50 same composer or different

sent-about-citable-and-dualism-2(thisartist dualism):
    "“" ?ac=@thisartist>make_cite $ac>strip_the>upcase-first "” "
    makes-statement-about " " dualism " " position-word " "
    [ "“" ?ac=@thisartist>make_cite $ac>strip_the |
      cc=citable-artist "’s “" ?ac=@$cc>make_cite $ac>strip_the ]
    "” " makes-statement-about " " dualism>opposite ". "
;

// This one is fun:
// Einstein on the Beach enforces capitalist masculinity where
//        Contrary motion asserts Marxist femininity
// if other artist is involved, puts other name in
// Einstein on the Beach enforces capitalist masculinity where
//        Beach’s Mass asserts Marxist femininity

sent-about-citable-and-dualism-2double(thisartist dualism dualadj):
    "“" ?ac=@thisartist>make_cite $ac>strip_the>upcase-first "” "
    makes-statement-about " " dualadj " " dualism
    " " position-word " "
    [ "“" ?ac=@thisartist>make_cite $ac>strip_the |
      cc=citable-artist "’s “" ?aac=@$cc>make_cite $aac>strip_the ]
    "” " makes-statement-about " " dualadj>opposite " " dualism>opposite ". "
;

position-word:
   "where"
   | "while"
   | "in the places where"
;

// the characteristic feature of Ross’s "Rest is Noise"
// is also evident in "The Ring Cycle", albeit tangentally.
sentence-with-features(c-artist):
    ?first-cite=@c-artist>make_cite

    "the " feature-of " " c-artist
    "’s “" $first-cite>strip_the "” "
    is-also-evident-in " “"
    [ @c-artist>make_cite | @citable-artist>make_cite ] "”" adverb-postjustify ". "
;

sentence-about-citable-artist(c-artist):
          sentence-with-features(c-artist)
  | sent-about-citable-and-dualism(c-artist dualisable-noun)
  | sentence-contrasting-citable-artist-works(c-artist)
  | justifier "the works of " c-artist " are " works-state-of-being ". "
;


// But in "Music with Changing Parts," Glass espouses neo-commonplace
// performance; in "Einstein on the Beach", by contrast, Glass denies
// structuralist bimusicality.

sentence-contrasting-citable-artist-works(artistname):
        "in “" @artistname>make_cite ",” " artistname " "
        says-something
        "; in “"
        @artistname>make_cite "”, "
        however " " artistname>artist-gender-pronoun " "
        says-something-else(artistname)
  ". "
;


// e.g.: the Conservatory’s reinventing of musical form, and insistence on instead
// hearing the music which is a central argument of musical form, reframes,
// indeed reenacts, Marxist communism

sent-about-big-neb-thing:
       big-neb-or-institution "’s " ing-ing  " of " thisbig=big-thing
       [ "" | ", and " insistence-on-thing($thisbig) ]
        " " says-or-makes-statement ". "
;

says-or-makes-statement:
    says-something
    | says-something
    | makes-statement-about " " term
    | makes-statement-about ", " indeed " " makes-statement-about ", " term
;

insistence-on-thing(th):
    "insistence " optional-instead " on  " ing-ing " the " insistence-on-thing-2(th)
;

insistence-on-thing-2(th):
    big-thing " " in-term " " th ","
    | something-about-works " " th ","
;

big-neb-or-institution:
    big-nebulous-thing
    | institution
;

sentence-about-self:
    "my " self-reflect " " abst-description " "
    [ self-statement-found | self-statement-promotes ]
    optional-concluding-ramble
    ". "
;

self-statement-found:
    found " that a statement like “" result-2 "” " not-exist
;

// advances a sociology of remose in the Abbatian-sociololinguistic vein
self-statement-promotes:
    promotes>trim_s " a " profession-of " of " of-antecedent " in the " intellectual "ian-" abst-noun "ist " vein
;

vein:
    "vein"
    | "mode"
    | "style"
;

// a musicology of difference ; a politic of remorse
profession-of:
    "musicology" | "politic" | "scholarship" | "linguistics" | "sociology" | "music theory" | "discipline"
;

of-antecedent:
    "remorse"
    | "new perspectives"
    | "difference"
    | "identity"
    | "deprivileging"
    | "sounds"
    | abst-concept
;

// statement following "my"
// "own prior unpublished discoveries"
self-reflect:
    reflect-preamble reflect-plural-noun
;

reflect-preamble:
    "" | own-unpublished " " | previous-prior " " | "auto-ethnographical " | reflect-preamble reflect-preamble
;

reflect-plural-noun:
    "thoughts" | "publications" | "discoveries" | "investigations"
;

own-unpublished:
    "own" | "personal" | "unpublished" | "forthcoming"
;

previous-prior:
    "previous" | "prior"
;


// was unused in pomo.pb so I took it
something-about-works: ""
  | optional-contrived "use of narrative in "
  | optional-inherent "musical structure of "
  | "semiotics of "
;

optional-contrived:
    "contrived " | ""
;

optional-inherent:
    ""
    | "inherent "
    | "constituted "
;

works-state-of-being:
    "postmodern"
    | "not postmodern"
    | "modernistic"
    | "an example of " informal-adj " " ideology
    | "reminiscent of " v-artist<<artist
    | "empowering"
;

says-something: makes-statement-about " " term ;

says-something-else(artistname):
    says-something
    | changes " "
      artistname>artist-gender-pronoun>possessivify-pronoun " "
      opinion [ " " degree | "" ] ", " optional-instead concentrating-on " " term
;

changes:
    "changes"
    | "changes"
    | "alters"
    | "nuances"
    | "circumvents"
    | "problematizes"
;

opinion:
    "opinion"
    | "mind"
    | "stance"
    | "views"
    | ["overarching " | "" ] "philosophy"
;

degree:
    "completely" | "totally" | "somewhat" | "a bit" |
    "imperceptably" | "obviously" | "rather"
;
optional-instead:
    ""
    | "instead "
    | "instead "
    | "rather "
;

// usually rather, sometimes instead
rather:
    "rather"
    | "rather"
    | "instead"
;


concentrating-on:
    "concentrating on"
    | "focusing on"
    | "turning an " sense-organ " to"
    | "being concerned with"
    | "drawing attention to"
;

sense-organ:
   "eye" | "eye" | "eye" | "eye" | "eye" |
   "ear" | "ear" | "ear"
;

makes-statement-about:
    "affirms" | "denies" | "reiterates" | "reframes"
    | "examines" | "analyses" | "reenacts" | "enforces"
    | "espouses" | "condemns" | "contrasts" | "indexes"
;

feature-of:
    dualism-desc " distinction " in-term
  | "example of " term " " in-term
  | something-of " of " term " " in-term
;

// question statements
// "Nevertheless why must romantic canon--perhaps surprisingly defined
//  by a pre-rationalist neo-experimentalist cultural theory--analyse the
//  romanticist concept of context, itself constrained by modern
//  Schenkerianism?"

but: "" | "but " | "yet " | "nevertheless ";

why: "" | "why " | "why " | "when " | "for whom " | "how ";

modal-verb-phrase:
    modal-verb
    | modal-verb
    | modal-verb ", " indeed " " modal-verb ","
;

modal-verb: "could" | "must" | "can" | "should" | "would" | "might";

say: "say" | "say" | "write" | "argue" | "insist" | "assert";

indeed:
    "or " indeed2
    | "or " indeed2
    | "and " indeed2
    | "and/or " indeed2
    | indeed2 | indeed2 | indeed2 | indeed2 | indeed2
;

indeed2:
    "indeed"
    | "even"
    | "better"
    | "some " modal-verb " " say
    | "we " modal-verb " " say
    | "one " modal-verb " " say
;
subject-noun: term | term | object-noun | object-noun | writer | composer;

// object-nouns do not include proper names
object-noun: "the " role | institution | big-thing | victim
              | bogeyman | term | term;
question-verb-phrase: singular-verb |
                      singular-verb ", " indeed " " singular-verb ", "
;
optional-constraint-subj: constraining-clause | " ";
optional-constraint-obj:  "" | constraint-obj;
constraint-obj:
    " (itself " constraining-clause-2 ")"
    | ", conversely " constraining-clause-2
    | ", itself " constraining-clause-2
    | ", similarly " store-const<<constraining-clause-2
    | ": which " also-word " is " store-const<<constraining-clause-2
;

also-word:
   "too" | "also"
;

constraining-clause:
    set-off-interjection(store-const=constraining-clause-2)
;

set-off-interjection(phrase):
  " (" phrase ") "
  | ", " phrase ", "
  | "—" phrase "—"
;

constraining-clause-2:
    amount-phrase constrained-by
    optional-article
    adj-clause " "
    [ abst-noun>strip_the | term>strip_the ]
;

amount-phrase:
    ""
    | degree " "
    | adv " "
;

optional-article: "" | "a " | "the ";
adj-clause: adj | adj " " adj;
constrained-by: "constrained by " | "defined by " | "hampered by "
                | "seeking only to escape " | "trapped by "
                | "fleeing " | "standing up to "
;


question-sentence:
    but why modal-verb-phrase " " subject-noun
    optional-constraint-subj
    question-verb-phrase " " object-noun
    optional-constraint-obj
    "? "
    optional-following-sentence
;

optional-following-sentence: "" | "" | following-sentence;

following-sentence:
    "The " answer " is " obvious-adj ". "
    | "The " answer " for " v-artist<<artist " proceeds as follows: "
    | "For the " answer ", one turns to " person
                        " (" year ": " measure-range "). "
    | "A " adj-clause " " [ "response" | answer ]
      " is given in " citable-response ". "
;
answer:
    "answer"
    | "answer"
    | "solution"
    | "response"
    | "reply"
;

citable-response:
    newcitable-response
    | oldcitable-response
;
newcitable-response: cc=citable-artist "’s “"
                    ?first-cite=@$cc>make_cite $first-cite>strip_the "”";
oldcitable-response: v-citable<<citable-artist "’s “"
                    ?first-cite=@$v-citable>make_cite
                    $first-cite>strip_the "”";


is-also-evident-in: "emerges " intensifier-pre-in " in" | "is also evident in" ;

in-term:
    "prevalent in"
    | "intrinsic to"
    | "depicted in"
    | "which is a central argument of" ;

adverb-postjustify:
    ""
    | ""
    | ""
    | though-postjustify
    | though-postjustify
    | though-postjustify
    | though-postjustify
    | though-postjustify
    | " (in the background)"
    | ", to a " ist-ist " mindset"
    | ", given the context"
    | " (taking its surroundings into account)"
    | " (contra " foo=musicologist " " footnote-cite($foo)>trim_space ")"
;

though-postjustify:
    ", " though " in a more " informal-adj " sense"
    | ", " though " in a " informal-adj " mode"
    | ", " though " " tangental-cursorily
;

though:
   "although"
   | "albeit"
   | "though"
;

tangental-cursorily:
    rather-degree " " tangental-cursorily-2
;

rather-degree:
    ""
    ""
    | "rather"
    | degree
;

tangental-cursorily-2:
    "tangentally"
    | "cursorily"
;


work: foo=generic-surname "’s" footnote-cite($foo) work-about " " term
    | "the works of " v-citable<<citable-artist
;

sentence-containing-measure-numbers:
     sentence-containing-measure-numbers-2 ". "
;

//This genius, or rather paradigm, is also evident in measures 222-229 of
//Beethoven’s Hammerklavier Sonata, although in a more redundant sense, and
//again in mm.  227-251, 36-58, and (in retrograde) in 74-87.

sentence-containing-measure-numbers-2:
   the-or-this " " something-of-2
   something-of-2-chain
   transition-seen
   measure-work-citation
   cc=citable-composer "’s "
   ?first-cite=@$cc>make_cite
   $first-cite>strip_the adverb-postjustify
   optional-intensifier-pre-in " "
   in-measure-range
   optional-earlier-works
;

the-or-this: "the" | "this";

transition-seen:
   "can be " seen-word optional-adv " in " |
   is-also-evident-in " " |
   "quotes "
;

something-of-2-chain:
    " " |
    ", or " rather " " something-of-2 ", " |
    ", or as some might say " adj2 comma-spliced-optional-adj2 " " something-of-2 ", "
;

comma-spliced-optional-adj2: "" | ", " adj2;

optional-intensifier-pre-in:  "" | "" | ", and " intensifier-pre-in;

intensifier-pre-in: "again" | "further" | "yet stronger";

measure-work-citation:
   measure-word " " measure-range " of "
;

measure-word: "mm." | "measures" | "bars";

in-measure-range:
    in-throughout " " measure-word " " measure-range optional-measure-range
        "and " distorted-measure-range-prefix measure-range
;
the-some: "the" | some;

some:
    "some" | "a few" | "many"
;

optional-measure-range: " " | ", " measure-range ", ";

distorted-measure-range-prefix:
    ""
    | ""
    | ""
    | ""
    | "(in retrograde) in "
    | "inverted in "
    | "paraphrased in "
    | "hinted at in "
;

earlier-works:
      ", " earlier-works-2 | " (" earlier-works-2 ")"
;

earlier-works-2:
   and-also optional-earlier-phrase " "
   optional-earlier-deintensifier
   in-throughout " "
   the-some " " works-word " of " hist-composer
;

and-also:
    "and" | "and" | "also"
;

works-word: "works" | "works" | "pieces" | "compositions" | "oeuvre";

in-throughout: "in" | "throughout";

optional-earlier-phrase: "" | ", earlier," | " foreshadowed";

optional-earlier-deintensifier:
   "" | "in embryonic form " | adv " " | ITALIC("passim ")
;

optional-earlier-works: "" | "" | earlier-works;

seen-word: "seen" | "observed" | "heard" | "felt";


// parametric sentences: a parametric sentence about a concept

// an abstract alternative

accept-or-reject: "accept" | "reject" ;
accept-reject-complicit: accept-or-reject | accept-or-reject | "be complicit in";

p-abst-altern(conc):
    p-abst-altern-2(conc)
    | p-abst-altern-2(conc) p-abst-altern-postamble
;

p-abst-altern-postamble:
    " and " consequently " " accept-reject-complicit " that " result
;

consequently:
    "consequently" | "subsequently" | "rightly" | "reflexively"
;


p-abst-altern-2(conc):
    accept-or-reject " " idea-source "’s " work-about
    " " conc
;

p-sentence-choice-concept(conc): "the " role " has a " choice ": "
        p-either(p-abst-altern(conc)) p-abst-altern(conc)
  ". "
;

// descriptions of abstract things, like theories and discourses

// the general case
abst-description:
    " " abst-description-concerning " " term-or-concept-desc
;

abst-description-concerning:
    "concerning"
    | "about"
    | "relating to"
;

abst-desc-plural:
    abst-description
    | " that includes "
;

term-or-concept-desc: term | concept-desc ;

plural-numeric-adj:
    "any number of"
    | "a number of"
    | "many"
    | "an abundance of"
    | "several"
    | "many sites for"
;

// "a number of things *"
exist:
    "exist"
    | "persist"
    | "may be " found
    | "are" optional-adv " " found
    | not-exist
;
not-exist:
    "cannot exist"
    | "cannot be " found
;

found:  "found" | "discovered" | "revealed" | "uncovered";

promotes: "promotes" | "suggests" ;

// imperative verb phrase "use narrative to "
imper-vp:
    imper-neg-verb " " bogeyman
    | imper-verb " " big-thing
;

// something you want to do to something bad
imper-neg-verb:
    "attack"
    | "challenge"
    | "rehear"
    | "problematize"
    | "read " read-preposition
;

read-preposition:
    "around"
    | "past"
    | "through"
;

imper-verb:
    imper-verb2
    | imper-verb2 " and " imper-verb2
;

imper-verb2:
    imper-neg-verb
    | "analyse"
    | "read"
    | "modify"
;

main-theme-of:
    main " " theme " of"
    | main " " theme " of"
    | main " " theme " of"
    | theme " characterizing"
    | theme " of"
    | theme " of"
    | ITALIC("Haupttema") " of"
;

main: "main" | "primary" | "principal" | "characteristic" ;

theme: "theme" | "idea" | "focus" | "thesis" ;

// something to ``justify'' a point.

justifier:
    just-name=generic-surname footnote-cite(just-name<<generic-surname) implies-that
    | "if " term " " is-be " " true-false ", "
;

// pretentious subjunctive
is-be:
   "is" | "be"
;
true-false:
   "true" | "false"
;

// a description of a concept

concept-desc:  "the " something-of " of " adj " " big-thing
  | "the " something-between " between " big-thing " and " big-thing
  | p1-concept-desc(abst-noun)
  | "the role of the " role " as " role
  | "a " informal-adj " " big-singular-thing
;

// parametric concept descriptions, taking a noun

p1-concept-desc(thing):
    "not" in-fact " " thing ", but " modifier-prefix thing
    | "not " thing per-se ", but " modifier-prefix thing
    | "neither " thing ", nor " modifier-prefix thing ", but " rather " " modifier-prefix thing
    | "both " thing " and " modifier-prefix thing
    | modifier-prefix ", " modifier-prefix ", and " modifier-prefix thing
;

// redundant smalltalk

in-fact:
    ", in fact, "
    | ""
;

per-se:
    " as such"
    | " per se"
    | ", as " person " would have it"
    | ", as " term " suggests"
    | ", as " composer " would write"
    | ""
;

// modifier prefix; used to modify a word.

modifier-prefix:
    "post-" | "post-" | "neo-" | "sub-" | "pre-" | "so-called "
    | "all-too-" | "meta-" | "proto-" | "quasi" | "super-" | "de-"
    | "trans-" | "inter-"
;

something-between:
    "difference" | "bridge" | "common ground" | "transition" | "mediation"
;

thus:
    "thus" | "hence" | "therefore" | "ergo,"
;

something-of:
    something-of-2
    | something-of-2 ", and subsequent " something-of-2 ","
    | something-of-2 ", and " thus " the " something-of-2 ","
    | something-of-2 ", and eventually the " something-of-2 ","
    | something-of-2 ", and some would say the " something-of-2 ","
;

something-of-2:
    "failure" | "futility" | "collapse" | "genius"
    | "stasis" | "modulation" | "absurdity" | "paradigm" | "sensitivity"
    | "pigeonholing" | "newness" | "defining characteristic" | "dialectic" | "economy"
    | "obligation" | "form"
;

// preamble; redundant preamble to sentence

preamble:
   "however, "
   | "it could be said that "
   | thus " "
   | thus " "
   | "in a sense, "
   | "in a larger sense, "
   | "but "
;

// redundant word between other words, like "however"

however: "" | "however, " | "however, " | "though, " | "by contrast, ";

// result: "It is stated that *"

result: result-2 | result-2 postcondition ;

result-2:
    big-abst-thing " " is-used-to " " ends
    | big-nebulous-thing " " comes-from " " source
    | big-thing optional-adv " has " to-have property
    | big-abst-or-institution " is " state-of-being
    | "the "  purpose-word " of the " role " is " goal
    | big-abst-or-institution " is capable of " capability
;

result-with-preamble:
     result
     | "one can " assume " that " result
     | intellectual "’s " model " of " term " " is-one-of "“" new-term "”, and "
        thus " " state-of-being
;


to-have: "" | "" | "" | "" | "to have " | "hints of " | "undertones of ";

assume:
    "assume"
    | "assume"
    | "suppose"
    | "believe"
;

model:
    "model" | "conception" | "definition"
;

is-one-of:
    "is one of" | "takes for granted" | "is based on" | "grounds itself in"
;

// something that can be used as an assumption: "If * holds",
assumption:  term
  | intellectual "’s " work-about " " term
  | pi=intellectual "’s " work-about " " @$pi>make_concepts
  | "the premise of " term
;

// binary relations

relation:
     "is equal to"
     | "is distinct from"
     | "is interchangeable with"
     | "is roughly equivalent to"
     | "is in binary opposition to"
;

// value-adjectives "the conceptual paradigm of discourse is *"

value-adj: "valid" | "invalid" | "uncertain" | "to be believed" | "a challenge";

// a primitive condition: "Assuming that *,..."

prim-condition:
        assumption " is " value-adj
  | big-abst-thing " " relation " " big-abst-thing
;

// corollary: "...as long as foo is bar*"

corollary:
    "; if that is not the case, " result-with-preamble
    | "; otherwise, " result-with-preamble
    | ""
;

postcondition: ", given that " prim-condition
  | ", but only if " prim-condition corollary
  | ""
;

abst-adverb: "fundamentally" | "intrinsically"
;

// i.e., "language is *"
state-of-being:  state-of-being-2 | abst-adverb " " state-of-being-2
  | "part of the " something-of-2 " of " big-abst-thing
        | big-abst-thing
;

state-of-being-2:
    "impossible" | "a human construction" | "unattainable"
    | "a " is-white "European construct" | "responsible for " bogeyman
    | "used in the service of " bogeyman
    | "fictionalized" | "problematic"
;

is-white: "" | "" | "white " | "(white) " | scare-quote("white") " ";

property:
    "intrinsic meaning" | "significance" | "real worth"
;

// ends: "foo is used to *". Predominantly negative.

ends:
    neg-verb " " victim
    | neg-verb " otherwise " pos-adj " " victim
    | pos-neg-verb " " bogeyman
;

implies-that:
    "implies that "
    | "states that "
    | "holds that "
    | "suggests that "
;

is-used-to:
    "is used to"
    | "serves to"
    | "may be used to"
;

comes-from:
    "comes from"
    | "must come from"
    | "is a product of"
    | "is created by"
;

source:  "notated music" | "our worth-system" | "the " performers
;

performers: performer | performer>pluralise;

performer: "performer" | "performer" | "composer" | "musician"
       | "improviser" | "musicker"
;

// either give a new term or rehash the old term

term:
    new-term
    | v-subject<<new-term
    | v-subject-2<<new-term
    | v-subject-3<<new-term
;

new-term:
    p-intell-term(v-person=intellectual)
    | ?v-person=intellectual @$v-person>make_concepts
    | adj " " abst-noun
    | adj " " abst-noun
    | adj " " adj " theory"
    | "the " adj " " term-concept " of " big-nebulous-thing
    | adj " " ideology
;

term-concept:
   "concept"
   | "concept"
   | "concepts"
   | "construction"
   | "conception"
   | "concept(s)"
   | "ideal"
;

summary:
    conclusion-preamble " it is " clear-obvious-adj " that "
    the-some " " relationships " among "
    v-subject<<new-term ", " v-subject-2<<new-term
    ", and " v-subject-3<<new-term
    summary-digression
    moving-toward " " ist-ist
    " "  goal-syn ". "

    further-conjunction>upcase-first " " study-verb
    " of " v-citable<<citable-artist
    "’s works, " especially " “"
    @$v-citable>make_cite ",” in "
    context-conjunction " "
    p-intell-term(intellectual) " and the " role "’s " adj " "
    abst-noun " will be the " concrete-noun-gets-you-there " to " goal "."
;

conclusion-preamble-it-is:
    conclusion-preamble " it is "
    | conclusion-preamble " it is "
    | conclusion-preamble " it is "
    | "It is "
;

summary-digression:
    set-off-interjection(summary-digression-2)
;

summary-digression-2:
    not-to-mention " " new-term ", which " reason-for-not-writing
;

moving-toward:
    "are evolving towards a more"
    | "are moving in the direction of a"
    | "are turning to the"
;

further-conjunction:
    "further" | "increased" | "more"
;

study-verb:
    "study"
    | "examination"
;

context-conjunction:
    "the context of"
    | "conjunction with"
;

especially:
    "especially"
    | "in particular"
;

goal-syn:
    "goal"
    | "end"
;

relationships:
    "relationships"
    | "connections"
;

not-to-mention:
    "not to mention"
    | "to say nothing of"
    | "even ignoring"
    | "and also"
;

conclusion-preamble:
    "In conclusion,"
    | "In sum,"
    | "At last,"
;

reason-for-not-writing:
    "we have barely had space to touch upon"
    | "will be the topic of our upcoming " work-type
    | "particularly applies to " adj " works"
    | musicologist " has written about far better than we can"
;

// term about an intellectual
// FIXME:  "Foucauldian" instead of "Foucaultist"
p-intell-term(i): i"ist " @i>make_concepts
;

ist-ist:
    ideology>adjectivise-ism
    | social-movement>adjectivise-ism
;

ideology:
    "minimalism" | "serialism" | "romanticism"
    | "post-romanticism" | "bimusicality" | "modernism" | "nationalism"
    | "postmodernism" | "experimentalism" | "rationalism"
    | foo=ideology " " ITALIC("qua") " " $foo
;

social-movement:
    "surrealism" | "modernism" | "realism" | "feminism"
    | "Marxism" | "capitalism" | "expressionism" | "deconstructionism"
    | "urbanity" | "neoliberism"
;

adjectivise-ism:
    ".*ism" -> "ism$"/"ist"
    ".*ity" -> "ity$"/"ist"
;

self-adj:
    "referential" | "sufficient" | "justifying" | "supporting"
    | "repeating" | "fulfilling" | "identifying" | "denying"
;

// an adjective which may not be used in formal terms

informal-adj:
    adj
    | "self-" self-adj
    | "redundant"
;

adj:
    adj2
    | adj2
    | modifier-prefix adj2
;

// an adj2 is an adjective which may end with "ist" or not.
// and appears in terms

adj2:
    "romantic"
    | adj3
    | adj3>trim_e "ist"
    | scare-quote(adj3)
    | "cultural"
    | "textual"
    | dualisable-adjective
    | social-movement>adjectivise-ism
    | ideology>adjectivise-ism
    | scare-quote("scientific")
;

adj3:
    "structural" | "semiotic" | "modern" | "Schenkerian"
    | "conceptual" | "material" | "triadic" | "sexual"
    | "cryptographic" | "clandestine"
    | "ecomusicological"
    | "hermeneutic"
    | "sonorous"
;

// adverbs

optional-adv: "" | ", " adv "," ;

adv:
    adv-2
    | "perhaps " adv-2
    | "somewhat " adv-2
;

adv-2:
    "paradoxically"
    | "surprisingly"
    | "ironically"
    | "subversively"
    | "usefully"
;

abst-noun:
  abst-noun2
  | "theory"
  | "composition"
  | "narrative"
  | "performance"
  | "ambiguity"
  | "canon"
  | abst-noun2
  | "proto-" abst-noun2
  | "self-" abst-noun2
;

abst-noun2:
    "composition"
    | adj3>trim_e "ism"
    | "construction"
    | "prolongation"
    | "appropriation"
    | "performance"
    | "theorizing"
    | "improvisation"
    | "analysis"
;

singular-verb:
    neg-verb
    | neg-verb
    | pos-verb
    | neut-verb
    | pos-neg-verb
    | imper-verb2
;

// these use postive and negative closely
sentence-about-heroes-and-victims:
    sentence-about-heroes-and-victims-using-dualisables
    | p-sentence-about-heroes-and-victims(neg-adj pos-concrete-adj)
;

sentence-about-heroes-and-victims-using-dualisables:
    ?pos-local=dualisable-positive-adjective
    p-sentence-about-heroes-and-victims($pos-local>opposite $pos-local)
;

p-sentence-about-heroes-and-victims(neg-local pos-local):
    ["though " | "although " | position-word " "]
    ["" | neg-adj " " ]
    bogeyman>strip_the>pluralise " "
    [ seek-to " " | "" ]
    pos-neg-verb " "
    neg-local " " abst-local=big-abst-thing
    ", "
    [ "the contributions of " | "" ]
    heroes
    optional-alternatively " "
    imper-neg-verb " " $abst-local
    " and "
    [ succeed-in " "  advance-verb>gerund | advance-verb ] " "
    pos-local " " $abst-local
    ", " advance-verb>gerund " "
    [ victim | term ]
    ". "
    optional-post-cite
;

// things bad guys try to do, but never succeed
seek-to:
    "seek to"
    | "try to"
    | "attempt to"
    | "aim to"
;

// things good folks do and always succeed
// followed by gerund
succeed-in:
    "succeed in"
    | "find success in"
    | "prevail in"
    | "thrive in"
    | "prosper by"
    | "overcome by"
    | "flourish in"
    | "surmount by"
;



optional-post-cite:
    ""
    | ""
    | "(" foo=generic-surname footnote-cite($foo)>trim_space ") "
;

// verbs for bad concepts
neg-verb:
    "marginalize"
    | "transgress"
    | "obscure"
    | "conflate"
    | "distort"
    | "negate"
    | "consign"
    | "privilege"
    | scare-quote(neg-verb)
    | neg-verb " and even " neg-verb
;

pos-verb:
    pos-but-generic-verb
    | advance-verb
;

pos-but-generic-verb:
    "fulfill"
    | "conclude"
    | "resolve"
    | "prolong"
    | "propagate"
    | "transcend"
;

advance-verb:
    "amplify"
    | "advance"
    | "promote"
    | "bolster"
    | "uphold"
    | "enrich"
    | "sustain"
    | "empower"
    | "foreground"
    | "envoice"
;

neut-verb:
    "restate"
    | "contextualize"
    | "manifest"
    | "decouple"
    | "situate"
;

// verbs positive to negative concepts
// bad people do this to bad things
pos-neg-verb:
    "reinforce"
    | "entrench"
    | "respell"
;

// victims to help
victim:
    singular-victim
    | plural-victim
;

// singular for grammatical purposes; may be collective nouns
singular-victim:
    "the Other"
    | "popular music"
    | "the bystander"
    | "the disabled"
    | "popular culture"
;
plural-victim:
   "subcultures"
   | "women"
   | "diverse actors"
   | "LGBTQ persons"
;

// heroes -- can also be victims
heroes:
   plural-victim
   | plural-victim
   | "women’s rights"
   | "gay studies"
   | "ethnomusicological approaches"
   | "interdisciplinary scholars"
   | "multicultural thinkers"
;


// bogeymen boogymen
// things we want to be rid of
bogeyman:
    "elitism"
    | "hierarchy"
    | "the status quo"
    | "globalization"
    | "the musicologist"
    | "sexism"
    | neg-adj " perceptions of " big-thing
    | "homophobia"
    | "the canon"
    | "the critic"
    | "modes of exclusion"
;

neg-adj:
    neg-adj1
    | neg-adj2
    | neg-adj1 ", " neg-adj2
    | neg-white;

neg-adj1:
    "outdated"
    | "outmoded"
    | "archaic"
    | "neoliberal"
    | "cis-normative"
;

neg-adj2:
    "fixed"
    | "inflexible"
    | "elitist"
    | "static"
    | "capitalist"
    | "conservative"
    | dualisable-positive-adjective>opposite
    | dualisable-positive-adjective>opposite
;

// bad groups to be a part of
neg-white:
   "white"
   | "male"
   | "heteronormative"
   | "cisgendered"
   | "white, male"
   | "white, male, heterosexual"
   | "white, cis-male, heterosexual"
;

pos-adj:
    pos-whishy-washy-adj
    | pos-concrete-adj
;

// positive, but not to be used in terms
pos-whishy-washy-adj:
    "affirming"
    | "rich"
    | "thriving"
    | "growing"
;

// positive and to be used in terms
pos-concrete-adj:
  pos-concrete-adj2
  | dualisable-positive-adjective
;
pos-concrete-adj2:
  "native"
  | "Global"
  | "diverse"
  | "postmodern"
;

work-about:
    "critique of"
    | "essay on"
    | "analysis of"
    | "model of"
    | "monograph on"
;

work-type:
    "essay"
    | "article"
    | "book"
    | "monograph"
    | "digital media project"
;

big-thing:
    "society"
    | "music"
    | big-abst-thing
    | big-abst-thing
;

big-abst-thing:
    "culture" | "language" | "art" | "performance" | "truth"
    | "sexuality" | "composition" | "memory" | "politics" | "scholarship"
    | "ambiguity" | "physicality" | "disability" | "history"
    | "musical form"
    | big-abst-thing " " ITALIC("vis-a-vis") " " big-abst-thing
;

institution:
    "the Conservatory"
    | "the concert hall"
    | "academe"
    | "society"
    | "the orchestra"
    | "the stage"
    | "musicology"
    | "ethnomusicology"
;

big-abst-or-institution:
    big-abst-thing | institution
;

// nebulous things: "* is a product of communication"
big-nebulous-thing:
    "music"
    | "performance"
    | "listening"
    | "expression"
    | "narrative"
    | "context"
    | "composition"
    | "analysis"
;

// "narrativity as a *"

big-singular-thing: "entity" | "whole" | "paradox" | "totality" | "worth system";

// "The discourse of *"

abst-concept:
    "progress" | "difference" | "gender"
    | "exoticism" | "disability" | "alterity"
    | "race" | "labor" | "experience"
    | "nostalgia" | "pluralism"
    | "culture"
    | "human " abst-concept
    | "multiple " abst-concept>pluralise
;

purpose-word: "purpose" | "goal" | "task" | "significance" ;

subject-object: "subject" | "object" | "individual" | role;

// roles, "deconstruction is the task of the *"

role: role2 | role2 | role2 | role2 | role2 | role2 | role2 " per se" | role2 "-" role2 | role2 "/" role2 ;

role2: "artist" | "observer" | "participant" | performer | performer |
      "listener" | "composer" |
      "analyst" | "(ethno-)musicologist" | "musicologist" | "critic";

// goals: "the goal of the artist is *"

goal: "clear depiction" | "progression" | "artistic comment" | "prolongation" | "mere masturbation";

capability: goal | intent-variant | "truth" | "content" ;

intent-variant: "intent" | "intention" | "intentionality" ;

// dualities

dualisable-word:
    dualisable-noun | dualisable-adjective
;
dualisable-noun:
    "opening" | "closing" | "foreground" | "background"
    | "creation" | "destruction"
    | "masculinity" | "femininity"
    | "tonality" | "atonality"
    | "minimalism" | "serialism"
    | "homosexuality" | "heterosexuality"
    | "triads" | "dyads"
    | "West" | "East"
    | "withinness" | "withoutness"
    | "self" | "Other"
;

dualisable-adjective:
    "masculine" | "feminine"
    | "tonal" | "atonal"
    | "common-practice" | "serial"
    | "minimalist" | "serialist"
    | "popular" | "art"
    | "Western" | "World"
    | "queer" | "straight"
    | "canonical" | "experimental"
    | "anthropological" | "analytical"
    | "major" | "minor"
    | "tonic" | "dominant"
    | "diminished" | "augmented"
    | "ambiguous" | "uncritical"
    | "capitalist" | "Marxist"
    | "gnostic" | "drastic"
    | "exotic" | "commonplace"
    | "transgendered" | "cisgendered"
    | "insider" | "outsider"
    | "“highbrow”" | "“lowbrow”"
    | "discrete" | "continous"
    | "conservative" | "liberal"
;

// the positive side of a dualisable adjective
// where one-side is clearly right
dualisable-positive-adjective:
    "feminine"
    | "popular"
    | "World"
    | "queer"
    | "experimental"
    | "ambiguous"
    | "Marxist"
    | "transgendered"
    | "liberal"
;



opposite:
    "opening" <-> "closing"
    "figure" <-> "ground"
    "withinness" <-> "withoutness"
    "creation" <-> "destruction"
    "masculine" <-> "feminine"
    "masculinity" <-> "femininity"
    "tonality" <-> "atonality"
    "homosexuality" <-> "heterosexuality"

// MSAC
    "minimalism" <-> "serialism"
    "tonal" <-> "atonal"
    "common-practice" <-> "serial"
    "minimalist" <-> "serialist"
    "popular" <-> "art"
    "Western" <-> "World"
    "queer" <-> "straight"
    "canonical" <-> "experimental"
    "anthropological" <-> "analytical"
    "tonic" <-> "dominant"
    "triads" <-> "dyads"
    "major" <-> "minor"
    "diminished" <-> "augmented"
    "ambiguous" <-> "uncritical"
    "capitalist" <-> "Marxist"
    // thank you Abbate and Puri!
    "gnostic" <-> "drastic"
    "exotic" <-> "commonplace"
    "West" <-> "East"
    "transgendered" <-> "cisgendered"
    "insider" <-> "outsider"
    "self" <-> "Other"
    "“highbrow”" <-> "“lowbrow”"
    "discrete" <-> "continuous"
    "conservative" <-> "liberal"
;

// e.g. "popular/art" "figure/ground" "Western/"Western""
i-dualism-desc(word): word "/" word>opposite ;

dualism-desc:
  i-dualism-desc(dualisable-word) |
  i-dualism-desc(dualisable-word) |
  i-dualism-desc(dualisable-word) |
  i-dualism-desc(dualisable-word) |
  i-dualism-desc(dualisable-word) |
  foone=dualisable-word "/" scare-quote($foone) |
  foone=dualisable-word "/" scare-quote($foone>opposite)
 ;

// names of intellectuals cited in pomo texts
// they have concepts associated with them

intellectual:
  "McClary" | "Bloom" | "Adorno"
  | "Marx" | "Derrida" | "Kramer" | "Abbate" | "Wagner" | "Eco" | "Solie"
  | "Brett" | "Solomon" | "Heidegger" | "Cheng" | "Straus" | "Cusick" | "Born"
;

// authors of books; not necessarily all major contributors to new musicology discourse but
// good for rounding out the discussion.

book-author: "Agawu" | "Lockwood" | "Cohn" | "Lewin" | "Babbitt" |
             "Rosen" | "Oja" | "Van Orden" | "Tick" |
             "Dell'Antonio" | "Morris" | "Fink" |
             "Auner" | "Sisman" | "Levitz" | "Dubiel" | "Hisama"
             "Taruskin" | "Tymoczko" | "Mosley"
;

// names, randomly generated

name: first-name " " generic-surname
        | first-name " " generic-surname
        | first-name " " generic-surname
        | first-name " " initial generic-surname
        | first-name " " initial initial generic-surname
        | initial first-name " " generic-surname ;

// first names, used for making names

first-name:
// Germanic names
  "Andreas" | "Hans" | "Rudolf" | "Wilhelm" | "Stefan" | "Helmut"
  | "Ludwig" | "Reinhold" | "Christoph" | "Christian" | "Matthias"
  | "Bettina" | "Seda" | "Arni"
  | "Rene"
// generic or English-sounding names
  | "David" | "John" | "Linda" | "Charles" | "Thomas"
  | "Barbara" | "Jane" | "Stephen" | "Henry" | "Susan" | "Anna"
  | "Paul" | "Catherine" | "Martin" | "Stefano" | "Michael"
  | "Gina" | "Aaron" | "Drew"
  | "Rebecca" | "Eleanor" | "Jessica"
  | "Emily" | "Elina" | "Samuel" | "Lindsay"
// 2025 finally time for a few non-white names as plausible!
  | "Luis" | "Hector" | "Maria" | "Tabitha" | "Kumi" | "Yu"
;



// the surnames of people I know (of), used for effect.
generic-surname:
    "Bent"
    | "Berger" | "Katz" | "Zaslaw" | "Shreffler"
    | "Stone" | "Clark" | "Cumming"
    | "Webster" | "Clemmens" | "Haggh" | "Trippett"
    | "Owens" | "Slim" | "Amati-Camperi" | "Peattie" | "Planchart"
    | "Cuthbert" | "Randel" | "Girard" | "Allen"| "Roeder" | "Wissner"
    | "Rodin" | "Kelly" | "Exner" | "Varwig" | "MacCarthy" | "Friedland"
    | "Rivera" | "Massey" | "Fitzpatrick"
    | "Ronyak"
    | "Goodman" | "Linklater" | "Ingolfsson"
    | "Brinkmann" | "Harris" | "Wegman"
    | "Pollock" | "Hamilton" | "Dorf" | "Bellmann" | "Wright"

    // 2025 finally time for a few non-white names as plausible!
    | "Chen" | "Wen" | "Kim" | "Gonzales" | "Lopez"
;

// Initials

initial:
  "A. " | "B. " | "C. " | "D. " | "E. " | "F. " | "G. " | "H. "
  | "I. " | "J. " | "K. " | "L. " | "M. " | "N. " | "O. " | "P. "
  | "Q. " | "R. " | "S. " | "T. " | "U. " | "V. " | "W. "
  | "Y. " | "Z. "
  | "Ll. "
;

initials: initial | initial | initial | initial | initial initial | initial initial initial ;

year: "19" recent-decade digit | "19" recent-decade digit |
      "19" digit digit | "200" digit | "201" digit | "202" year-digit | "18" recent-decade digit;

// digits of this decade
year-digit: "0" | "1" | "2" | "3" | "4" | "5";

recent-decade: "8" | "9";

digit: "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
non-zero-digit: "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
non-zero-digit-or-space: "" | "" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;

measure-range: { a=1..300; c=1..30; b=a+c } $a "–" $b;


// publishers

publisher:
// serious music publishers
  "University of " university-of " Press"
  | "University of " university-of " Press"
  | something-university " University Press"
  | something-university " University Press"
// other
  | "W.W. Norton" | "McGraw Hill"
// small departments but big pomo...
  | "Indiana University Press"
  | "Wesleyan University Press"
  | "M.I.T. Press"
// vanity that everyone uses
  | "Edward Mellyn Press"
  | "Scarecrow Press"
;

// a footnote, in the *roff ms package.

opt-ed: "" | "" | "ed. " | "ed./trans. ";

footnote-cite-text(surname):
    surname ", " [initials | first-name " "]
    opt-ed
    "(" year ") "
    ITALIC([title "."]) " " publisher
;
// note how ITALIC([...]) has only one option, but
// it allows for evaluating an atom within a param call -- otherwise
// not tested/documented.  ITALIC(title ".") would be a two-argument call.

footnote-cite(surname):
    FOOTNOTE(footnote-cite-text(surname))
;

// sources of quotes, cites, etc.

idea-source:
    intellectual | intellectual | artist | artist
    | book-author | hist-intel | hist-musicologist;

// intellectuals who are part of the historical landscape


hist-intel:
    hist-composer |
    "Aristotle" | "Plato" | "Hume" | "Nietzsche"
;

musicologist: writer | writer | hist-musicologist | book-author | generic-surname;

hist-musicologist:
    "Burney" | "Besseler" | "Rameau" | "Reese"
    | "Riemann" | "A. B. Marx" | "Tovey" | "Dahlhaus";

hist-composer:
    "Mozart" | "Monteverdi" | "Rousseau" | "Berlioz" | "Bach"
    | "Machaut" | "Debussy" | "Riemann" | "Haydn" | "Ives"
    | "Handel"
;


// names of artists whose work may be analysed and deconstructed
// Citable artists are those whose names can map to rules listing their
// works.

artist: composer | writer;
composer: citable-composer | uncitable-composer;
writer: citable-writer | citable-writer| citable-writer | uncitable-writer;

citable-artist: citable-composer | citable-writer;

citable-composer:
    "Ueno"| "Zorn" | "Bizet" | "Björk" | "Radiohead" |
    "Cage" | "Mahler" | "Reich" | "Glass" | "Wagner" |
    "Crawford" | "Saariaho" | "Beethoven" | "Beach" | "Rorem" |
    "Muhly" | "Williams" | "Shaw" | "Oliveros"
;

uncitable-composer:
    "Monk" | "Feldman" | "Ono" | "Barraque" | "Boulez"
    | "Beyonce" | "Timberlake" | "Lady Gaga"
;

// writers can also be intellectuals
citable-writer: "Adorno" | "Cage" | "McClary" | "Abbate" | "Solie" |
                "Brett" | "Straus" | "Tomlinson" | "Cusick" |
                "Fuller" | "Mann" | "Koestenbaum" | "Sherr" |
                "Ross" | "Born";

uncitable-writer:
    "Puri" | "Beckerman" |
    "Mockus" |  // Pauline Oliveros and Lesbian Musicality
    "Attinello" | "Ta-Nehisi Coates" |
    // 2025 additions
    "McWhorter"
;


// needed for citables
artist-gender-pronoun:
    "Cage" -> "he"
    "Mann" -> "he"
    "Reich" -> "he"
    "Monk"  -> "she"
    "Feldman" -> "he"
    "Crawford" -> "she"
    "Saariaho" -> "she"
    "Beethoven" -> "he"
    "Beach" -> "she"
    "Rorem" -> "he"
    "Zorn" -> "he"
    "Bizet" -> "he"
    "Sherr" -> "he"
    "Björk" -> "she"
    "Radiohead" -> "it"
    "Ueno" -> "he"
    "Muhly" -> "he"
    "Brett" -> "he"
    "Koestenbaum" -> "he"
    "Adorno" -> "he"
    "McClary" -> "she"
    "Abbate" -> "she"
    "Solie" -> "she"
    "Fuller" -> "she"
    "Ross" -> "he"
    "Glass" -> "he"
    "Mahler" -> "he"
    "Straus" -> "he"
    "Cusick" -> "she"
    "Tomlinson" -> "he"
    "Williams" -> "he"
    "Shaw" -> "she"
    "Oliveros" -> "she"
    "Born" -> "she"
//    "Maxwell" -> "she"
//    "Zayaruznaya" -> "they"
;

possessivify-pronoun:
    "she" -> "her"
    "he" -> "his"
    "it" -> "its"
    "they" -> "their"
;

// works of citable artists

Cage-works: "I-VI" | "Silence" | "Composition as Process" | "A Year from Monday" |
            "Empty Words" | "X" | "Notations";
Reich-works: "Music as Gradual Process" | "Pendulum Music" | "Slow Motion Sound" |
             "Violin Phase" | "Clapping Music" | "Different Trains" |
             "Vermont Counterpoint";
Glass-works: "Einstein on the Beach" | "Koyaanisqatsi" | "Music with Changing Parts" |
             "Contrary Motion";
Bizet-works: "the Toreador song" | "the Habanera" | "the flower aria" | "the Seguidilla";
Björk-works: "Hunter" | "Bachelorette" | "Vespertine" | "Isobel";
Radiohead-works: "O.K. Computer" | "Kid A" | "The Bends";
Ueno-works:
     "On a Sufficient Condition for the Existence of Most Specific Hypothesis"
     | "...blood blossoms..."
     | "Entropy of Cigarette Butts Across the Universe"
     | "Yellow 632";
Wagner-works: "Tristan" | "Rheingold" | "Goetterdammerung" | "Parsifal" | "Music and Drama";
Mahler-works: "Lied von den Erde" | "the Fourth Symphony" | "the Fifth Symphony" |
              "Kindertotenlieder";
Crawford-works: "Study in Mixed Accents" | "Diaphonic Suite" |
                "String Quartet (1931)";
Beach-works: "the Gaelic symphony" | "the Mass" | "the Piano Quintet";
Rorem-works: "String Quartet No. 3" | "Five Poems of Walt Whitman";
Saariaho-works: "Du cristal" | "Lichtbogen" | "...a la fumee" | "Nymphea";
Beethoven-works: "the Eroica" | "the Ninth Symphony" | "the Hammerklavier Sonata" |
           "the Fifth Symphony" | "the Pastoral Symphony" | "Fidelio";
Zorn-works: "Cat o' Nine Tales" | "Forbidden Fruit" | "Masada" | "Spillane";
Muhly-works: "I Drink the Air Before Me" | "Mothertongue";
Williams-works: "Star Wars" | "Schindler’s List" | "Last Jedi" | "Imperial March" ;
Shaw-works: "Partita" | "String Quartets" ;
Oliveros-works: "Deep Listening" | "Sonic Meditations" ;

// works of citable writers
Abbate-works:
    "Unsung Voices" | "In Search of Opera" | "Music and Discourse"
    | "Opera, or The Envoicing of Women"
;
Adorno-works:
    "the Mahler book" | "the Philosophy of New Music"
    | "Dissonanzen: Musik in der verwalteten Welt" | "Quasi una fantasia"
;
McClary-works:
    "Feminine Endings" | "Conventional Wisdom"
    | "Modal Endings" | "Unruly Passions and Courtly Dances"
    | "Music, the Pythagoreans, and the Body"
;
Fuller-works:
    "Queer Episodes in Music and Modern Identity"
    | "The Pandora Guide to Women Composers"
;
Solie-works:
    "Musicology and Difference"
    | "Music in Other Words: Victorian Conversations"
    | "Tadpole Pleasures"
    | "Defining Feminism: Conundrums, Contexts, Communities"
;

Brett-works: "Queering the Pitch" | "Decomposition: Post-Disciplinary Performance" |
             "Cruising the Performative: Interventions into the Representation of Ethnicity, Nationality, and Sexuality" |
             "Editing Renaissance Music"
;
Koestenbaum-works: "The Queen’s Throat" | "Hotel Theory" | "Humiliation";
Mann-works: "The Magic Mountain" | "Doktor Faustus";
Sherr-works: "A Distressing Incident: Choirboys, Canons, and Homosexuality" |
        "Guglielmo Gonzaga and the Castrati" | "Competence and Incompetence";

Ross-works:
     "The Rest is Noise"
     | "Listen to This"
     | "articles for the New Yorker"
;
Born-works: "Music, Sound and Space" | "Uncertain Vision" | "Rationalizing Culture";

Straus-works: "Disability and Late Style in Music" |
              "Extraordinary Measures" | "Sounding Off" |
              "Remaking the Past" | "the Crawford Seeger book";
Cusick-works:
     "Music as Torture"
     | "Francesca Caccini"
     | "On a Lesbian Relationship with Music";
Tomlinson-works:
     "Music in Renaissance Magic: Toward a Historiography of Others"
     | "Metaphysical Song"
     | "The Singing of The New World: Indigenous Voice"
     | "1,000,000 Years of Music";


// concepts associated with intellectuals
// God bless Amazon.com and SIPs

McClary-concepts: "feminism" | "new musicology";
Bloom-concepts: "anxiety of influence" | "misprision";
Adorno-concepts: "dialectic";
Marx-concepts: "communism" | "socialism";
Eco-concepts: "open work" | "open form";
Derrida-concepts: "deconstruction" | "postmodernism";
Kramer-concepts: "queer musicology" | "other-voicedness" | "strategic dislocation";
Abbate-concepts: "voicelessness" | "narrativity";
Wagner-concepts: ITALIC("Gesamtkunstwerk") | "Leitmotiv";
Solie-concepts:
    "difference" | "gender study"
    | "new organology" | "female authorial voice";
Brett-concepts: "musical closet" | "phallic economy";
Cusick-concepts:
    "power/pleasure/intimacy triad" | "listener flattening"
    | "musical/sexual negotiation" | "no-touch torture";
Solomon-concepts: "peacock-culture" | "nobility pretense" ;
Heidegger-concepts: "hermeneutics" | "Da-sein" | "hermeneutic circle";
Straus-concepts: "disability musicology";
Tomlinson-concepts: "Hermeneutic dialogue";
Cheng-concepts: "musicology of caring";
Born-concepts: "encompassment";

// mappings start here

// trim trailing 'e's from word. Used when deriving "deconstructivist" from
// "deconstructive", for instance.

trim_e:
    ".*e$" -> "e$"/""
;

trim_s:
    ".*s$" -> "s$"/""
    ".*s with$" -> "s with"/" with"
;

would_will:
    "would" -> "would"/"will"
;

strip_the:
    "^[Tt]he.*" -> "^[Tt]he "/""
;

trim_space:
    ".* $" -> " $"/""
;

// make an artist’s name into the symbol representing his/her works

make_cite:
    ".*" -> "$"/"-works"
;

make_concepts:
    ".*" -> "$"/"-concepts"
;

pluralise:
    ".*y$" -> "y$"/"ies"
    ".*s$" -> "$"/"es"
    ".*" -> "$"/"s"
;

past-tensify:
    ".*e$" -> "$"/"d"
    ".*" -> "$"/"ed"
;

gerund:
    ".*e$" -> "e$"/"ing"
    ".*" -> "$"/"ing"
;

// scarequote -- a function not a mapping

scare-quote(scarything):
    "“" scarything "”"
;
