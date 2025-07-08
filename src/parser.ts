import type { Token } from './tokenizer.ts';

interface Rule {
  type: 'rule';
  name: string;
  options: (string | { ref: string; transforms?: string[] })[][];
}

interface Transform {
  type: 'transform';
  name: string;
  rules: { pattern: string; target: string; replacement: string }[];
}

export type Statement = Rule | Transform;

export function parse(tokens: Token[]): Statement[] {
  let i = 0;

  function peek(): Token {
    return tokens[i];
  }

  function next(): Token {
    return tokens[i++];
  }

  function expect(type: Token['type'], value?: string): Token {
    const token = next();
    if (token.type !== type || (value !== undefined && token.value !== value)) {
      throw new Error(`Expected ${type} ${value ?? ''}, got ${token.type} ${token.value}`);
    }
    return token;
  }

  function parseRule(): Rule {
    const name = expect('identifier').value;
    expect('symbol', ':');
    const options: (string | { ref: string; transforms?: string[] })[][] = [];
    let currentOption: (string | { ref: string; transforms?: string[] })[] = [];

    while (true) {
      const token = peek();
      if (token.type === 'string') {
        currentOption.push(token.value);
        next();
      } else if (token.type === 'identifier') {
        let ref = token.value;
        let transforms: string[] = [];
        next();
        while (peek().type === 'greater') {
          next();
          const transformName = expect('identifier').value;
          transforms.push(transformName);
        }
        currentOption.push({ ref, transforms: transforms.length > 0 ? transforms : undefined });
      } else if (token.type === 'symbol' && token.value === '|') {
        next();
        options.push(currentOption);
        currentOption = [];
      } else if (token.type === 'symbol' && token.value === ';') {
        next();
        options.push(currentOption);
        break;
      } else {
        break;
      }
    }

    return { type: 'rule', name, options };
  }

  function parseTransform(): Transform {
    const name = expect('identifier').value;
    expect('symbol', ':');
    const rules = [];

    while (peek().type === 'string') {
      const pattern = expect('string').value;
      expect('arrow', '->');
      const target = expect('string').value;
      expect('slash', '/');
      const replacement = expect('string').value;
      expect('symbol', ';');
      rules.push({ pattern, target, replacement });
    }

    return { type: 'transform', name, rules };
  }

  function parseStatements(): Statement[] {
    const statements: Statement[] = [];

    while (peek().type !== 'eof') {
      const token = peek();
      if (token.type === 'identifier') {
        if (
          tokens[i + 1]?.type === 'symbol' &&
          tokens[i + 1].value === ':' &&
          tokens[i + 2]?.type === 'string' &&
          tokens[i + 3]?.type === 'arrow'
        ) {
          statements.push(parseTransform());
        } else {
          statements.push(parseRule());
        }
      } else if (token.type === 'directive') {
        // skip %trans for now
        while (peek().type !== 'symbol' || peek().value !== ';') {
          next();
        }
        next(); // consume ';'
      } else {
        throw new Error(`Unexpected token: ${token.type} ${token.value}`);
      }
    }

    return statements;
  }

  return parseStatements();
}
