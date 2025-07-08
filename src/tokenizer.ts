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

  const skipWhitespace = () => {
    while (i < input.length && /\s/.test(input[i])) {
      i++;
    }
  };

  const match = (regex: RegExp): string | null => {
    const matched = input.slice(i).match(regex);
    if (matched && matched.index === 0) {
      i += matched[0].length;
      return matched[0];
    }
    return null;
  };

  while (i < input.length) {
    skipWhitespace();

    if (i >= input.length) break;

    if (input.startsWith('//', i)) {
      while (i < input.length && input[i] !== '\n') {
        i++;
      }
      continue;
    }

    if (input[i] === '"') {
      let str = '';
      i++; // Skip opening quote
      while (i < input.length && input[i] !== '"') {
        if (input[i] === '\\' && i + 1 < input.length) {
          if (input[i + 1] === '\\') {
            str += '\\';
            i += 2;
          } else if (input[i + 1] === '"') {
            str += '"';
            i += 2;
          } else {
            str += input[i];
            i++;
          }
        } else {
          str += input[i];
          i++;
        }
      }
      i++; // Skip closing quote
      tokens.push({ type: 'string', value: str });
      continue;
    }

    if (input.startsWith('->', i)) {
      i += 2;
      tokens.push({ type: 'arrow', value: '->' });
      continue;
    }

    if (input[i] === '>') {
      i++;
      tokens.push({ type: 'greater', value: '>' });
      continue;
    }

    if (input[i] === '/') {
      i++;
      tokens.push({ type: 'slash', value: '/' });
      continue;
    }

    const directive = match(/^%\w+/);
    if (directive) {
      tokens.push({ type: 'directive', value: directive });
      continue;
    }

    const identifier = match(/^\w+/);
    if (identifier) {
      tokens.push({ type: 'identifier', value: identifier });
      continue;
    }

    const symbol = match(/^[;:\|]/);
    if (symbol) {
      tokens.push({ type: 'symbol', value: symbol });
      continue;
    }

    throw new Error(`Unexpected character at position ${i}: '${input[i]}'`);
  }

  tokens.push({ type: 'eof', value: '<eof>' });
  return tokens;
}
