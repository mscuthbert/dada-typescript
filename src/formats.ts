/*
 * HTML and Plaintext formats for the TypeScript PB/Dada parser.
 *
 * Copyright (c) 2025 Michael Scott Asato Cuthbert
 * BSD License: Some Rights Reserved
 */
import { tokenize } from './tokenizer.ts';
import {parse, type Rule, type Statement} from './parser.ts';

type RuleMap = Record<string, Rule>;

function rulesFromInput(input: string): RuleMap {
    const tokens = tokenize(input);
    const statements: Statement[] = parse(tokens);
    const rules: RuleMap = {}
    for (const stmt of statements) {
        if (stmt.type === 'rule') {
            rules[stmt.name] = {...stmt, lastChoice: -1};  // don't carry over lastChoice
        }
    }
    return rules;
}

export function plainRules(): RuleMap {
    let input = `
// PROLOGUE: format-specific prologue

%resource PROLOGUE: {PLAIN_section_num=0; PLAIN_footnote_num=0;
  PLAIN_footnotes="" } "";

// EPILOGUE: format-specific epilogue

%resource EPILOGUE: "\n\n----\n" $PLAIN_footnotes;

// BODY: called when body text is to start

%resource BODY: "";

// TITLE(t): generates code at start of output for title

TITLE(t): t "\n\n" ;

// AUTHOR(au):  generates a formatted author name; usually used after the
// title

AUTHOR(au): au "\n\n" ;

// AUTHOR_INST(auth inst):  generates a formatted author name and institution;
// usually used after the title.

AUTHOR_INST(auth inst): auth "\n" inst "\n\n";

// SECTION(title):  generates a numbered section title.

SECTION(title):  { PLAIN_section_num = PLAIN_section_num+1 } "\n\n\t"
    $PLAIN_section_num ". " title>upcase-first "\n";

// FOOTNOTE(text):  generates a numbered footnote

FOOTNOTE(text): ?tx=text // the inline-code parameter bug^H^H^Hfeature.
 { PLAIN_footnote_num=PLAIN_footnote_num+1 }
 " [" $PLAIN_footnote_num "] "
 // append the text to the accumulating footnotes
 { PLAIN_footnotes = PLAIN_footnotes + PLAIN_footnote_num+". " + tx + SLASH_N }
;

// BRK: generates a line break

%resource BRK: "\n";

// PBRK: generates a paragraph break

%resource PBRK: "\n\n";

// ************************************************************************
//
// Text styles and the like
//
// ************************************************************************

// here, text styles aren't really used.

BOLD(foo): foo ;
ITALIC(foo): foo ;
CENTER(foo): food ;
    `;
    input = input.replace('SLASH_N', '`\n`');
    return rulesFromInput(input);
}

export function htmlRules(): RuleMap {
    let input = `
// PROLOGUE: format-specific prologue

%resource PROLOGUE: { HTML_section_num=0; HTML_footnote_num=0 ;
  HTML_footnotes=""
} {HTML_BODY="<main>"};

// EPILOGUE: format-specific epilogue

%resource EPILOGUE: "<hr><p>\n" $HTML_footnotes "</main>";

// BODY: called when body text is to start

%resource BODY: $HTML_BODY {HTML_BODY=""};

// TITLE(t): generates code at start of output for title

TITLE(t): $HTML_BODY { HTML_BODY="" } "<h1 class='title'>" t "</h1>" "\n" ;

// AUTHOR(au):  generates a formatted author name; usually used after the
// title

AUTHOR(au): "<h2>" au "</h2>\n" ;

// AUTHOR_INST(auth inst):  generates a formatted author name and institution;
// usually used after the title.

AUTHOR_INST(auth inst): "<h2 class='author'>" auth "</h2><h3 class='institution'>" inst "</h3>\n";

// SECTION(title):  generates a numbered section title.

SECTION(title): { HTML_section_num=HTML_section_num+1 } "<h3>"
\t$HTML_section_num ". " title>upcase-first "</h3>\n" ;

// FOOTNOTE(text):  generates a numbered footnote

FOOTNOTE(text): ?tx=text // parameters can't be used in inline code as such
  { HTML_footnote_num=HTML_footnote_num+1 } "<sup><a href='#fn" $HTML_footnote_num
  "'>[" $HTML_footnote_num "]</a><a id='fn-return" $HTML_footnote_num "'></a></sup> "
  {  // append the text to the accumulating footnotes
   HTML_footnotes = HTML_footnotes + "<p class='footnote'><a id='fn" + HTML_footnote_num + "'></a> "
   + "<a href='#fn-return" + HTML_footnote_num + "'>"
   + HTML_footnote_num + "</a>. " + tx + "</p>" + SLASH_N
}
;

// BRK: generates a line break

%resource BRK: "<br>\n";

// PBRK: generates a paragraph break

%resource PBRK: "<p>\n";


// ************************************************************************
//
// Text styles and the like
//
// ************************************************************************


BOLD(foo): "<b>" foo "</b>";
ITALIC(foo): "<i>" foo "</i>";
CENTER(foo): "<div style='text-align: center'>" foo "</div>";
    `;
    input = input.replace('SLASH_N', '`\n`');
    return rulesFromInput(input);
}
