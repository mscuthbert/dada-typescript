# Dada-Typescript

This is a new parser for the Dada Engine's PB format written entirely in TypeScript
to be run on the browser.

The reference implementation is:
https://dev.null.org/dadaengine/manual-1.0/dada.html

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
* Parametric rules
* Inline choices (anonymous rules)
* Resource rules (%resource)
* Silenced atoms (?colour="green")
* Indirection (@references)
* Text mappings: pattern style with slash
* Text mappings: source -> destination
* Text mappings: reversible <-> mappings
* upcase and upcase-first -- provided transformations from old stdmap.pbi

## Not Supported
* Kleene star \* and + characters
* Percent %trans mappings (however, upcase and upcase-first are provided by the system)
* Embedded Code
* Standard Library
* C-Processor User Parameters (-DNAME="Henry")
* C-style #define statements
* C-language #includes
* HTML Formatting
* Footnotes
* TROFF Formatting (no plans to integrate)

## Differences with c Parser + Clarifications
* Unknown rule errors are found only on generation, not parsing. A script may therefore
    pass sometimes but fail others depending on if the unknown rule is called.
* The original parser treated `#` as a comment, despite not being in the spec. Found in test/maptest.pb,
    test/test.pb.
    Updated tests to not use them.
* The original parser treated parametric rules as resource rules (for instance
    `BOLD(xxx)` was in format.pbi was not prefaced by `%resource`). This reading is retained here.
* The original parser did not allow parameters in inline choices (`[ x | y ]` expressions). Since
    this was called a restriction "in the current release" and it just worked in the Typescript
    interpreter, we're leaving it in.  The original parser also did not allow parameters to be
    used as variables in inline code. (It could be gotten around by aliasing with silencing,
    like `FOOTNOTE(text): ?tx=text { FOOTNOTE_TEXT=FOOTNOTE_TEXT + tx }`

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
