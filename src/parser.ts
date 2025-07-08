import type { Token } from './tokenizer.ts';

interface Rule {
  type: 'rule';
  name: string;
  parameters: string[];
  options: Option[][];
}

interface Transform {
  type: 'transform';
  name: string;
  rules: { pattern: string; target: string; replacement: string }[];
}

interface Ref {
  ref: string;
  transforms: string[];
  args?: Option[];
}

type Option = string | Ref;

export type Statement = Rule | Transform;

export function parse(tokens: Token[]): Statement[] {
  let i = 0;
  let currentRuleName: string | null = null;

  function peek(): Token {
    return tokens[i];
  }

  function next(): Token {
    return tokens[i++];
  }

  function expect(type: Token['type'], value?: string): Token {
    const token = next();
    if (token.type !== type || (value !== undefined && token.value !== value)) {
      throw new Error(`Expected ${type} ${value ?? ''}, got ${token.type} ${token.value}${currentRuleName ? ` (in rule: ${currentRuleName})` : ''}`);
    }
    return token;
  }

  function parseRule(): Rule {
    const name = expect('identifier').value;
    currentRuleName = name;
    let parameters: string[] = [];

    if (peek().type === 'symbol' && peek().value === '(') {
      next();
      while (peek().type !== 'symbol' || peek().value !== ')') {
        parameters.push(expect('identifier').value);
      }
      expect('symbol', ')');
    }

    expect('symbol', ':');
    const options: Option[][] = [];
    let currentOption: Option[] = [];

    while (true) {
      const token = peek();
      if (token.type === 'string') {
        currentOption.push(token.value);
        next();
      } else if (token.type === 'identifier') {
        let ref: Ref = { ref: token.value, transforms: [] };
        next();
        while (peek().type === 'greater') {
          next();
          ref.transforms.push(expect('identifier').value);
        }
        if (peek().type === 'symbol' && peek().value === '(') {
          next();
          const args: Option[] = [];
          while (peek().type !== 'symbol' || peek().value !== ')') {
            args.push({ ref: expect('identifier').value, transforms: [] });
          }
          expect('symbol', ')');
          ref.args = args;
        }
        currentOption.push(ref);
      } else if (token.type === 'symbol' && token.value === '|') {
        next();
        options.push(currentOption);
        currentOption = [];
      } else if (token.type === 'symbol' && token.value === ';') {
        next();
        options.push(currentOption);
        break;
      } else {
        throw new Error(`Unexpected token in rule: ${token.type} ${token.value}${currentRuleName ? ` (in rule: ${currentRuleName})` : ''}`);
      }
    }

    currentRuleName = null;
    return { type: 'rule', name, parameters, options };
  }

  function parseTransform(): Transform {
    const name = expect('identifier').value;
    currentRuleName = name;
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

    currentRuleName = null;
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
