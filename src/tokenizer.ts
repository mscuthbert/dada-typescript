export type Token =
  | { type: 'identifier'; value: string }
  | { type: 'string'; value: string }
  | { type: 'symbol'; value: string }
  | { type: 'arrow'; value: '->' }
  | { type: 'slash'; value: '/' }
  | { type: 'greater'; value: '>' }
  | { type: 'directive'; value: string }
  | { type: 'eof'; value: '<eof>' };

export function tokenize(input: string): Token[] {
  const tokens: Token[] = [];
  let i = 0;
  let line = 1;
  let column = 1;

  const advance = (n: number = 1) => {
    for (let j = 0; j < n; j++) {
      if (input[i] === '\n') {
        line++;
        column = 1;
      } else {
        column++;
      }
      i++;
    }
  };

  const skipWhitespaceAndComments = () => {
    while (i < input.length) {
      if (/\s/.test(input[i])) {
        advance();
      } else if (input[i] === '/' && input[i + 1] === '/') {
        while (i < input.length && input[i] !== '\n') {
          advance();
        }
      } else if (input[i] === '/' && input[i + 1] === '*') {
        advance(2);
        while (i < input.length && !(input[i] === '*' && input[i + 1] === '/')) {
          advance();
        }
        if (i < input.length) advance(2); // consume '*/'
      } else {
        break;
      }
    }
  };

  const match = (regex: RegExp): string | null => {
    const matched = input.slice(i).match(regex);
    if (matched && matched.index === 0) {
      advance(matched[0].length);
      return matched[0];
    }
    return null;
  };

  while (i < input.length) {
    skipWhitespaceAndComments();

    if (i >= input.length) break;

    if (input[i] === '"') {
      let str = '';
      advance();
      while (i < input.length && input[i] !== '"') {
        if (input[i] === '\\') {
          if (input[i + 1] === '"') {
            str += '"';
            advance(2);
          } else if (input[i + 1] === '\\') {
            str += '\\';
            advance(2);
          } else if (input[i + 1] === 'n') {
            str += '\n';
            advance(2);
          } else if (input[i + 1] === 't') {
            str += '\t';
            advance(2);
          } else {
            str += input[i];
            advance();
          }
        } else {
          str += input[i];
          advance();
        }
      }
      if (input[i] === '"') {
        advance();
        tokens.push({ type: 'string', value: str });
        continue;
      } else {
        throw new Error(`Unterminated string starting at line ${line}, column ${column}`);
      }
    }

    if (input.startsWith('->', i)) {
      advance(2);
      tokens.push({ type: 'arrow', value: '->' });
      continue;
    }

    if (input[i] === '>') {
      advance();
      tokens.push({ type: 'greater', value: '>' });
      continue;
    }

    if (input[i] === '/') {
      advance();
      tokens.push({ type: 'slash', value: '/' });
      continue;
    }

    const directive = match(/^%\w+/);
    if (directive) {
      tokens.push({ type: 'directive', value: directive });
      continue;
    }

    const identifier = match(/^[a-zA-Z_][\w-]*/);
    if (identifier) {
      tokens.push({ type: 'identifier', value: identifier });
      continue;
    }

    const symbol = match(/^[;:|()]/);
    if (symbol) {
      tokens.push({ type: 'symbol', value: symbol });
      continue;
    }

    throw new Error(`Unexpected character at line ${line}, column ${column}: '${input[i]}'`);
  }

  tokens.push({ type: 'eof', value: '<eof>' });
  return tokens;
}
