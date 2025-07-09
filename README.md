# Dada-Typescript

This is a new parser for the Dada Engine's PB format written entirely in TypeScript
to be run on the browser.

The reference implementation is:
https://dev.null.org/dadaengine/manual-1.0/dada.html

## Supported
(in order of manual-1.0)

* Comments (inline and multiline)
* Identifiers
* Literal Strings: Double quote, Newline, Tab
* Atoms
  - Literal Text
  - Symbols
* Variables (including "lazy &lt;&lt; assignment")
* Parametric rules
* Inline choices (anonymous rules)
* Silenced atoms (?colour="green")
* Text mappings: pattern style with slash
* upcase and upcase-first -- provided transformations from old stdmap.pbi

## Not Supported
* Literal Strings: Vertical tab, backspace, carriage return w/o newline, form feed, audible alert
* Kleene star \* and + characters
* Resource rules (%resource)
* Indirection (@references)
* Text mappings: source -> destination
* Text mappings: reversible <-> mappings
* Percent %trans mappings (however, upcase and upcase-first are provided by the system)
* Embedded Code
* Standard Library
* C-Processor User Parameters (-DNAME="Henry")
* C-style #define statements
* C-language #includes
* HTML Formatting
* Footnotes
* TROFF Formatting (no plans to integrate)

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
