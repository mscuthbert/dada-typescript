import type {
    Statement,
    Rule,
    Transform,
    Option
} from './parser.ts';

type Context = Record<string, string>;
type RuleMap = Record<string, Rule>;
type TransformMap = Record<string, Transform>;

export function generate(statements: Statement[], start: string): string {
    const rules: RuleMap = {};
    const transforms: TransformMap = {
        "upcase-first": {
            type: "transform",
            name: "upcase-first",
            rules: [{
                pattern: '.*',
                target: '^(.)',
                replacement: (_m: any, g: string): string => g.toUpperCase(),
            }]},
        "upcase": {
            type: "transform",
            name: "upcase",
            rules: [{
                pattern: '.*',
                target: '(.*)',
                replacement: (_m: any, g: string): string => g.toUpperCase(),
            }]},
    };
    const globalVars: Record<string, string> = {};

    for (const stmt of statements) {
        if (stmt.type === 'rule') {
            rules[stmt.name] = { ...stmt, lastChoice: -1 };
        } else if (stmt.type === 'transform') {
            transforms[stmt.name] = stmt;
        } // no other possible
    }

    function applyTransforms(value: string, names: string[]): string {
        for (const name of names) {
            const transform = transforms[name];
            if (!transform) {
                throw new Error(`Unrecognized transform "${name}" on generated value "${value}"`);
            }
            for (const rule of transform.rules) {
                const targetRegex = new RegExp(rule.target, 'g');
                if (new RegExp(rule.pattern).test(value)) {
                    if (typeof rule.replacement === 'string') {
                        value = value.replace(targetRegex, rule.replacement);
                    } else {
                        value = value.replace(targetRegex, rule.replacement);
                    }
                    // only one rule applies per mapping.
                    break;
                }
            }
        }
        return value;
    }

    function resolve(option: Option, context: Context): string {
        if (typeof option === 'string') {
            return option;
        }

        if ('kind' in option) {
            if (option.kind === 'get') {
                const result = globalVars[option.name] ?? '';
                return applyTransforms(result, option.transforms);
            }
            if (option.kind === 'set') {
                const val = resolve(option.value, context);
                globalVars[option.name] = val;
                return val;
            }
            if (option.kind === 'lazy') {
                if (!(option.name in globalVars)) {
                    const val = resolve(option.value, context);
                    globalVars[option.name] = val;
                }
                return globalVars[option.name];
            }
            if (option.kind === 'silenced') {
                resolve(option.value, context);
                return '';
            }
        }

        // Handle references
        if (option.ref in context) {
            return applyTransforms(context[option.ref], option.transforms);
        }

        const rule = rules[option.ref];
        if (!rule) {
            throw new Error(`Unknown rule: ${option.ref}`);
        }

        const localContext = { ...context };

        if (rule.parameters.length > 0) {
            if (!option.args || option.args.length !== rule.parameters.length) {
                throw new Error(`Incorrect number of arguments to rule ${option.ref}`);
            }
            for (let j = 0; j < rule.parameters.length; j++) {
                localContext[rule.parameters[j]] = resolve(option.args[j], context);
            }
        }

        let index: number;
        if (rule.options.length === 1) {
            index = 0;
        } else {
            do {
                index = Math.floor(Math.random() * rule.options.length);
            } while (index === rule.lastChoice);
        }
        rule.lastChoice = index;

        const choice = rule.options[index];
        let result = '';
        for (const part of choice) {
            result += resolve(part, localContext);
        }

        return applyTransforms(result, option.transforms);
    }

    return resolve({ ref: start, transforms: [] }, {});
}
