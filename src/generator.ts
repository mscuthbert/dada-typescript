import type { Statement } from './parser.ts';

interface Rule {
  type: 'rule';
  name: string;
  parameters: string[];
  options: Option[][];
  lastIndex?: number; // NEW
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

type Context = Record<string, string>;

type RuleMap = Record<string, Rule>;
type TransformMap = Record<string, Transform>;

export function generate(statements: Statement[], start: string): string {
  const rules: RuleMap = {};
  const transforms: TransformMap = {};

  for (const stmt of statements) {
    if (stmt.type === 'rule') {
      rules[stmt.name] = { ...stmt }; // retains optional lastIndex
    } else {
      transforms[stmt.name] = stmt;
    }
  }

  function applyTransforms(value: string, names: string[]): string {
    for (const name of names) {
      const transform = transforms[name];
      if (!transform) continue;
      for (const rule of transform.rules) {
        const targetRegex = new RegExp(rule.target, 'g');
        if (new RegExp(rule.pattern).test(value)) {
          value = value.replace(targetRegex, rule.replacement);
        }
      }
    }
    return value;
  }

  function resolve(option: Option, context: Context): string {
    if (typeof option === 'string') {
      return option;
    }

    if (option.ref in context) {
      return applyTransforms(context[option.ref], option.transforms);
    }

    const rule = rules[option.ref];
    if (!rule) {
      throw new Error(`Unknown rule: ${option.ref}`);
    }

    let localContext = { ...context };

    if (rule.parameters.length > 0) {
      if (!option.args || option.args.length !== rule.parameters.length) {
        throw new Error(`Incorrect number of arguments to rule ${option.ref}`);
      }
      for (let j = 0; j < rule.parameters.length; j++) {
        localContext[rule.parameters[j]] = resolve(option.args[j], context);
      }
    }

    let idx = Math.floor(Math.random() * rule.options.length);
    if (rule.options.length > 1 && idx === rule.lastIndex) {
      idx = (idx + 1 + Math.floor(Math.random() * (rule.options.length - 1))) % rule.options.length;
    }
    rule.lastIndex = idx;

    const choice = rule.options[idx];
    let result = '';
    for (const part of choice) {
      result += resolve(part, localContext);
    }

    return applyTransforms(result, option.transforms);
  }

  return resolve({ ref: start, transforms: [] }, {});
}
