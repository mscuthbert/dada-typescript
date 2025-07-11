# Dada-Typescript

This is a new parser for the Dada Engine's PB format written entirely in TypeScript
to be run on the browser.

The reference implementation is:
https://dev.null.org/dadaengine/manual-1.0/dada.html

## Command-line

After running `npm install` once, after this run

`npm start PBNAME`

for instance `npm start scripts/pomo.pb`.

## Supported
(in order of manual-1.0)

* Comments (inline and multiline)
* Identifiers
* Literal Strings:
  - Use these: Double quote, Newline, Tab,
  - Don't use these: Vertical tab, backspace, carriage return w/o newline, form feed, audible alert (bell)
* Atoms
  - Literal Text
  - Symbols
* Variables (including "lazy &lt;&lt; assignment")
* Kleene star \* and + characters
* Parametric rules
* Inline choices (anonymous rules)
* Resource rules (%resource)
* Silenced atoms (?colour="green")
* Indirection (@references)
* Text mappings: pattern style with slash
* Text mappings: source -> destination
* Text mappings: reversible <-> mappings
* upcase and upcase-first -- these transformations from old stdmap.pbi are provided automatically
* Standard Library Functions (PROLOGUE, TITLE, etc.)
* Embedded Code
* Footnotes
* HTML Formatting
* `%repeat(token, times)` (undocumented but used in crackpot and test/repeattest).

## Not Supported
* Arbitrary %trans mappings (however, %upcase and %upcase-first are provided by the system)
* C-Processor User Parameters (-DNAME="Henry")
* C-style #define statements
* C-language #includes
* TROFF Formatting
* Undocumented/unused/unimplemented Bison directives from lexer.x (e.g. %unique, %pick, %cond, %e).

## Differences with c Parser + Clarifications
* .pb files can be fully Unicode and are assumed to be encoded as UTF-8 files.
* Unknown rule errors are found only on generation, not parsing. A script may therefore
    pass sometimes but fail others depending on if the unknown rule is called.
* The original parser treated `#` as a comment, despite not being in the spec. Found in test/maptest.pb,
    test/test.pb.
    Updated tests to not use them.
* The original parser treated parametric rules as resource rules (for instance
    `BOLD(xxx)` was in format.pbi was not prefaced by `%resource`). This reading is retained here.
* The original parser did not allow parameters in inline choices (`[ x | y ]` expressions). Since
    this was called a restriction "in the current release" and it just worked in the Typescript
    interpreter, we're leaving it in.
* Spaces around ` = ` and ` << ` in set-var and get-var are currently not allowed.
* I've attempted to retain the operator precedences seen in the C parser:
    - `@param>trans` is parsed as `@(param>trans)` and not `(@param)>trans`.
    - `$var>trans` is treated as `($var)>trans` and not `$(var>trans)`
    - Because parentheses are not actually allowed, silenced temporary variables may be needed for cases where other operator precedence is desired.
    - For instance, musicology.pb uses `?ac=@$cc>make_cite $ac>strip_the` to retrieve variable `$cc`, make a citation from it, then (with `@` indirection) call the rule.  That output is stored as the silenced variable `ac` which is then retrieved to have any `the` removed from the front.
* `%repeat(..., -1)` will not parse on TypeScript (equal to repeat(..., 0) in C).  `%repeat(..., var)` where var is negative does "work" (prints nothing).
* Note that there is a bug in the C dada engine where + and * use `rand()` not `random()` and thus do
    not obey the random seed of `srandom()`. There are random cases in C where + will always give 5
    repetitions, etc. Obviously this bug is not duplicated in the Javascript version.

### Embedded Code Expression Differences and Clarification
Since Embedded Code in pb was designed to be evaluated by C, some differences were
bound to arise with a Javascript parser.

* The original parser did not allow parameters to be
    used as variables in inline code. (It could be gotten around by aliasing with silencing,
    like `FOOTNOTE(text): ?tx=text { FOOTNOTE_TEXT=FOOTNOTE_TEXT + tx }`)  They work in Javascript.
* The use of the `a..b` expression wasn't fully documented in the original pb and allowed expressions
    like `{a = 1..300; b=a+1..a+30 }` to assign `b` to a number between 1 and 30 above `a`.
    I could not easily make the operator work this way in Javascript, so now special operators
    have low priority.  To do the above statement call `{a = 1..300; c=1..30; b=a+c}` or
    `{a = 1..300; b=(a+1)..(a+30) }` with parentheses.
* Special operators cannot appear within parentheses in another special operator, so no
    `{=(a<<b)..(a>>b)}`.  This does work in the C version.
    Assign a different variable instead: `{c=a<<b; d=a>>b; e=c..d} $e`.
* Currently, if there is a parameter with the same name as a global variable but different values
    and a `{code block}` is run the global variable will be updated to the
    value of the local, even if the code block doesn't reference that name.
* Because Javascript will be evaluated strings like `{res="\n"}` will cause errors since it will
    put the whitespace on a new line.  Either write as `{res="\\n"}` or use backticks.
* A return statement in this Javascript version must be the first statement in the embedded code
    (the `{= ... }` expression is converted to a magic expression, but the `=` sign is
    only searched for at the beginning of the expression, after optional whitespace.)  Any
    other position of the leading `=` will probably result in syntax errors.
* Variable names with hyphens in them cannot be used in code bocks (`the-word` will be
    evaluated as the variable `the` subtracting the variable `word`).  I don't know if this worked
    in the C version.
* Currently there is no access inside code to Javascript functions except Math (masqueraded as __Math),
    but this should still not be considered secure not used in high security places. Parsing a string
    as a number can be done with `+var`; the reverse can be done with `''+var`.

## License
The software here is released under the BSD 3-clause license.  The pb scripts--
with the exception of securities.pb and sample.pb are by Andrew C. Bulhak and
therefore follow his original BSD Old (4-clause) license w/ his copyright.
musicology.pb is a hybrid of his pomo.pb and substantial new work by MSAC.

## Author

Michael Scott Asato Cuthbert (w/ AI assistance -- a babbler writing a babbler!)


# React + TypeScript + Vite

This template provides a minimal setup to get React working in Vite with HMR and some ESLint rules.

Currently, two official plugins are available:

- [@vitejs/plugin-react](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react) uses [Babel](https://babeljs.io/) for Fast Refresh
- [@vitejs/plugin-react-swc](https://github.com/vitejs/vite-plugin-react/blob/main/packages/plugin-react-swc) uses [SWC](https://swc.rs/) for Fast Refresh

## Expanding the ESLint configuration

If you are developing a production application, we recommend updating the configuration to enable type-aware lint rules:

```js
export default tseslint.config([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...

      // Remove tseslint.configs.recommended and replace with this
      ...tseslint.configs.recommendedTypeChecked,
      // Alternatively, use this for stricter rules
      ...tseslint.configs.strictTypeChecked,
      // Optionally, add this for stylistic rules
      ...tseslint.configs.stylisticTypeChecked,

      // Other configs...
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```

You can also install [eslint-plugin-react-x](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-x) and [eslint-plugin-react-dom](https://github.com/Rel1cx/eslint-react/tree/main/packages/plugins/eslint-plugin-react-dom) for React-specific lint rules:

```js
// eslint.config.js
import reactX from 'eslint-plugin-react-x'
import reactDom from 'eslint-plugin-react-dom'

export default tseslint.config([
  globalIgnores(['dist']),
  {
    files: ['**/*.{ts,tsx}'],
    extends: [
      // Other configs...
      // Enable lint rules for React
      reactX.configs['recommended-typescript'],
      // Enable lint rules for React DOM
      reactDom.configs.recommended,
    ],
    languageOptions: {
      parserOptions: {
        project: ['./tsconfig.node.json', './tsconfig.app.json'],
        tsconfigRootDir: import.meta.dirname,
      },
      // other options...
    },
  },
])
```
