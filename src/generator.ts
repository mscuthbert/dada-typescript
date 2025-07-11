/*
 * Text Generator for the TypeScript PB/Dada parser.
 *
 * Copyright (c) 2025 Michael Scott Asato Cuthbert
 * BSD License: Some Rights Reserved
 */
import type {
    Statement,
    Rule,
    TextMapping,
    Option,
    Ref,
} from './parser.ts';
import {
    Kleene,
} from './parser.ts';
import {plainRules, htmlRules} from "./formats.ts";

import {scopedEval} from './helpers.ts';

function isRef(obj: Option): obj is Ref {
    return typeof obj === 'object' && obj !== null && 'ref' in obj;
}
function isIntegerString(str: string): boolean {
    return /^-?\d+$/.test(str);
}


// Context are context variables -- global or parameter
type Context = Record<string, string>;
type RuleMap = Record<string, Rule>;
type TextMappingMap = Record<string, TextMapping>;

export function generate(statements: Statement[], start: string, format: 'none'|'plain'|'html' = 'plain'): string {
    let rules: RuleMap = {};
    if (format === 'plain') {
        rules = plainRules();
    } else if (format === 'html') {
        rules = htmlRules();
    }

    const textMappings: TextMappingMap = {
        "upcase-first": {
            type: "textMapping",
            name: "upcase-first",
            rules: [{
                pattern: '.*',
                target: '^(“?"?.)',  // upcase after quotes
                replacement: (_m: any, g: string): string => g.toUpperCase(),
            }]},
        "upcase": {
            type: "textMapping",
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
            rules[stmt.name] = {...stmt, lastChoice: -1};  // don't carry over lastChoice
        } else if (stmt.type === 'textMapping') {
            textMappings[stmt.name] = stmt;
        } // no other possible
    }

    function applyTextmappings(value: string, names: string[]): string {
        for (const name of names) {
            const textMapping = textMappings[name];
            if (!textMapping) {
                throw new Error(`Unrecognized textMapping "${name}" on generated value "${value}"`);
            }
            for (const rule of textMapping.rules) {
                const targetRegex = new RegExp(rule.target, 'g');
                if (new RegExp(rule.pattern).test(value)) {
                    if (typeof rule.replacement === 'string') {
                        value = value.replace(targetRegex, rule.replacement);
                    } else {  // not sure why the `if` is needed to get rid of errors here...
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
        if ('kleene' in option && option.kleene !== Kleene.None) {
            const oneTime = { ...option, kleene: Kleene.None };
            if (option.kleene === Kleene.Plus) {
                const newOption = { ...option, kleene: Kleene.Star };
                return resolve(oneTime, context) + resolve(newOption, context);
            } else {
                // Kleene.Star
                if (Math.random() > 0.5) {
                    return resolve(oneTime, context) + resolve(option, context);
                } else {
                    return '';
                }
            }
        }

        if ('kind' in option) {
            if (option.kind === 'string') {
                return applyTextmappings(option.value, option.textMappings);
            }
            if (option.kind === 'get') {
                const result = globalVars[option.name] ?? '';
                return applyTextmappings(result, option.textMappings);
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
            if (option.kind === 'repeat') {
                let num;
                if (typeof option.integer !== 'undefined') {
                    num = option.integer;
                } else {
                    const variable = option.variable || '';
                    if (variable in context) {
                        num = context[variable];
                    } else if (variable in globalVars) {
                        num = globalVars[variable];
                    } else {
                        throw new Error(`Unrecognized variable "${variable}" in %repeat`);
                    }
                    if (typeof num !== 'number') {
                        if (isIntegerString(num)) {
                            num = parseInt(num);
                        } else {
                            throw new Error(`Variable "${variable}" not holding an integer in %repeat`);
                        }
                    }
                }
                if (Number.isNaN(num)) {
                    throw new Error(`Value "${num}" is NaN in %repeat`);
                }
                // faster up to 10000 strings than Array.join:
                let out = '';
                for (let i = 0; i < num; i++) {
                    out += resolve(option.value, context);
                }
                return out;
            }

            if (option.kind === 'indirection') {
                const localOption = option.value;
                const refEval = resolve(localOption, context);  // will resolve textMappings
                // console.log('refEval', refEval);
                const rule: Rule = rules[refEval];
                if (!rule) {
                    throw new Error(`Indirection resolved to unknown rule: ${refEval}`);
                }
                // indirection with parameters currently not defined.
                let localRef: Ref | null = null;
                if (isRef(localOption)) {
                    localRef = {...localOption, textMappings: []};  // textMappings already done.
                } else {
                    localRef = {
                        ref: refEval,
                        textMappings: [],
                        args: [],
                        kleene: Kleene.None,
                    }
                }

                // console.log('localRef', localRef);
                const indirectionResolution = resolveRule(rule, localRef, context);
                // console.log('indirectionResolution', indirectionResolution);
                return indirectionResolution;
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
            return applyTextmappings(context[option.ref], option.textMappings);
        }

        const rule: Rule = rules[option.ref];
        if (!rule) {
            throw new Error(`Unknown rule: ${option.ref}`);
        }
        return resolveRule(rule, option, context);
    }

    // Here is the actual start of the program!
    return resolve({ ref: start, textMappings: [], kleene: Kleene.None }, {});

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
        return applyTextmappings(result, ref.textMappings);
    }
}
