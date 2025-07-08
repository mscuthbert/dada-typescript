import type { Statement } from './parser.ts';

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

type Scope = Record<string, Option[]>;

type TransformMap = Record<string, Transform['rules']>;

type RuleMap = Record<string, Rule>;

export function generate(statements: Statement[], start: string): string {
  const ruleMap: RuleMap = {};
  const transformMap: TransformMap = {};

  for (const stmt of statements) {
    if (stmt.type === 'rule') {
      ruleMap[stmt.name] = stmt;
    } else {
      transformMap[stmt.name] = stmt.rules;
    }
  }

  function applyTransforms(text: string, transforms: string[]): string {
    for (const t of transforms) {
      const rules = transformMap[t];
      if (!rules) continue;
      for (const { pattern, target, replacement } of rules) {
        const regex = new RegExp(pattern);
        if (regex.test(text)) {
          text = text.replace(new RegExp(target, 'g'), replacement);
        }
      }
    }
    return text;
  }

  function evalOption(opt: Option, scope: Scope): string {
    if (typeof opt === 'string') {
      return opt;
    }
    if (opt.args) {
      const rule = ruleMap[opt.ref];
      if (!rule) throw new Error(`Rule ${opt.ref} not found`);
      if (rule.parameters.length !== opt.args.length) {
        throw new Error(`Rule ${opt.ref} expects ${rule.parameters.length} args, got ${opt.args.length}`);
      }
      const newScope: Scope = { ...scope };
      rule.parameters.forEach((param, i) => {
        const arg = opt.args![i];
        newScope[param] = [arg];
      });
      const choice = rule.options[Math.floor(Math.random() * rule.options.length)];
      return choice.map(o => evalOption(o, newScope)).join('');
    } else {
      const resolved = scope[opt.ref] ?? ruleMap[opt.ref]?.options[Math.floor(Math.random() * ruleMap[opt.ref].options.length)];
      if (!resolved) throw new Error(`Reference ${opt.ref} not found`);
      const text = resolved.map(o => evalOption(o, scope)).join('');
      return applyTransforms(text, opt.transforms);
    }
  }

  const rule = ruleMap[start];
  if (!rule) throw new Error(`Start rule ${start} not found`);
  const chosen = rule.options[Math.floor(Math.random() * rule.options.length)];
  return chosen.map(o => evalOption(o, {})).join('');
}
