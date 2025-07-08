import type { Statement } from './parser.ts';

interface TransformRule {
  pattern: string;
  target: string;
  replacement: string;
}

interface Ref {
  ref: string;
  transforms?: string[];
}

export function generate(statements: Statement[], start: string): string {
  const rules = new Map<string, (string | Ref)[][]>();
  const transforms = new Map<string, TransformRule[]>();

  for (const stmt of statements) {
    if (stmt.type === 'rule') {
      rules.set(stmt.name, stmt.options);
    } else if (stmt.type === 'transform') {
      transforms.set(stmt.name, stmt.rules);
    }
  }

  function applyTransforms(text: string, transformNames?: string[]): string {
    if (!transformNames) return text;
    for (const name of transformNames) {
      const rules = transforms.get(name);
      if (!rules) throw new Error(`Unknown transform: ${name}`);
      for (const { target, replacement } of rules) {
        const re = new RegExp(target, 'g');
        text = text.replace(re, replacement);
      }
    }
    return text;
  }

  function expand(ruleName: string): string {
    const options = rules.get(ruleName);
    if (!options) {
      throw new Error(`Unknown rule: ${ruleName}`);
    }

    const chosen = options[Math.floor(Math.random() * options.length)];
    return chosen
      .map(part => {
        if (typeof part === 'string') {
          return part;
        } else {
          const result = expand(part.ref);
          return applyTransforms(result, part.transforms);
        }
      })
      .join('');
  }

  return expand(start);
}
