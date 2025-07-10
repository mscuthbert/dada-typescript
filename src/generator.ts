import type {
    Statement,
    Rule,
    Transform,
    Option,
    Ref,
} from './parser.ts';

import {scopedEval} from './helpers.ts';

function isRef(obj: Option): obj is Ref {
    return typeof obj === 'object' && obj !== null && 'ref' in obj;
}

// Context are context variables -- global or parameter
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
                context[option.name] = val;
                return val;
            }
            if (option.kind === 'lazy') {
                if (!(option.name in globalVars)) {
                    const val = resolve(option.value, context);
                    globalVars[option.name] = val;
                    context[option.name] = val;
                }
                return globalVars[option.name];
            }
            if (option.kind === 'silenced') {
                resolve(option.value, context);
                return '';
            }
            if (option.kind === 'indirection') {
                const localOption = option.value;
                const refEval = resolve(localOption, context);
                const rule: Rule = rules[refEval];
                if (!rule) {
                    throw new Error(`Indirection resolved to unknown rule: ${refEval}`);
                }
                // indirection with parameters currently not defined.
                let localRef: Ref | null = null;
                if (isRef(localOption)) {
                    localRef = localOption;
                } else {
                    localRef = {
                        ref: refEval,
                        transforms: [],
                        args: [],
                    }
                }

                return resolveRule(rule, localRef, context);
            }
            if (option.kind === 'code') {
                const originalGlobalKeys = new Set(Object.keys(globalVars));
                const originalContextKeys = new Set(Object.keys(context));
                const c2 = {...globalVars, ...context};
                const out = scopedEval(option.value, c2);

                // Update globalVars for existing keys
                for (const key of originalGlobalKeys) {
                    if (key in c2) {
                        globalVars[key] = c2[key];
                        // console.log(`Updated globalVars[${key}] to ${c2[key]}`);
                    }
                }

                // Add new keys from context that weren't there before
                for (const key of Object.keys(c2)) {
                    if (!originalContextKeys.has(key) && !originalContextKeys.has(key)) {
                        globalVars[key] = c2[key];
                        // console.log(`Adding new globalVars[${key}] as ${c2[key]}`);
                    }
                }
                return out;
            }
        }

        // Handle references
        if (option.ref in context) {
            return applyTransforms(context[option.ref], option.transforms);
        }

        const rule: Rule = rules[option.ref];
        if (!rule) {
            throw new Error(`Unknown rule: ${option.ref}`);
        }
        return resolveRule(rule, option, context);
    }

    return resolve({ ref: start, transforms: [] }, {});

    function resolveRule(rule: Rule, ref: Ref, context: Context) : string {
        // console.log('in resolve rule', ref.ref, context, globalVars);
        const localContext = { ...context };

        if (rule.parameters.length > 0) {
            if (!ref.args || ref.args.length !== rule.parameters.length) {
                throw new Error(`Incorrect number of arguments to rule ${ref.ref}`);
            }
            for (let j = 0; j < rule.parameters.length; j++) {
                localContext[rule.parameters[j]] = resolve(ref.args[j], context);
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

        // console.log('out resolve rule', ref.ref, localContext, globalVars);
        return applyTransforms(result, ref.transforms);
    }
}
