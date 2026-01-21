/*
 * Token to Rule (etc.) Parser for the TypeScript PB/Dada rewrite.
 *
 * Copyright (c) 2025 Michael Scott Asato Cuthbert
 * BSD License: Some Rights Reserved
 */
import type { Token } from './tokenizer.ts';

export interface Rule {
    type: 'rule';
    name: string;
    parameters: string[];
    options: Option[][];
    lastChoice: number;
    resource: boolean;
}

export interface TextMapping {
    type: 'textMapping';
    name: string;
    rules: { pattern: string; target: string; replacement: (string|((...args: any[]) => string)); }[];
}


// Options:

// instead of enum so that tsc can run without a transpiler:
export const Kleene = {
    None: 0,
    Star: 1,
    Plus: 2,
} as const;
export type Kleene = (typeof Kleene)[keyof typeof Kleene];

export interface BareString {
    kind: 'string';
    value: string;
    textMappings: string[];  // ridiculous, but possible!
    kleene: Kleene;
}

// TODO: rename to RuleRef
export interface Ref {
    ref: string;  // rename to ruleName
    textMappings: string[];
    args?: Option[];
    kleene: Kleene;
}

export interface SetVar {
    kind: 'set';
    name: string;
    value: Option;
}

export interface LazySetVar {
    kind: 'lazy';
    name: string;
    value: Option;
}

export interface GetVar {
    kind: 'get';
    name: string;
    textMappings: string[];
    kleene: Kleene;
}

export interface SilencedOption {
    kind: 'silenced';
    value: Option;
}

export interface Indirection {
    kind: 'indirection';
    value: Option;
}

export interface CodeBlock {
    kind: 'code';
    value: string;
    kleene: Kleene;
}

export interface Repeat {
    kind: 'repeat';
    value: Option;
    integer?: number;
    variable?: string;
    kleene: Kleene;
}

export type Option =
    BareString | Ref
    | SetVar | LazySetVar | GetVar
    | SilencedOption | Indirection
    | CodeBlock | Repeat;

export type Statement = Rule | TextMapping;


export function parse(tokens: Token[]): Statement[] {
    let i = 0;
    let currentRuleName: string | null = null;
    let anonCounter = 1;
    const statements: Statement[] = [];

    function peek(): Token {
        return tokens[i];
    }

    function next(): Token {
        return tokens[i++];
    }

    function expect(type: Token['type'], value?: string): Token {
        const token = next();
        if (token.type !== type || (value !== undefined && token.value !== value)) {
            throw new Error(`Expected ${type}${value ? ` ${value}` : ''}, got ${token.type} ${token.value}${currentRuleName ? ` (in rule: ${currentRuleName})` : ''}`);
        }
        return token;
    }

    function parseOption(): Option {
        const token = peek();

        if (token.type === 'string') {
            next();
            // transformations go after args.
            const bareString: BareString = { kind: 'string', value: token.value, textMappings: [], kleene: Kleene.None };
            while (peek().type === 'transform') {
                next();
                bareString.textMappings.push(expect('identifier').value);
            }
            return bareString;
        }

        if (token.type === 'silenced') {
            next();
            const value = parseOption();
            return { kind: 'silenced', value: value };
        }

        if (token.type === 'indirection') {
            next();
            const value = parseOption();
            return { kind: 'indirection', value: value };
        }

        if (token.type === 'code') {
            next();
            return { kind: 'code', value: token.value, kleene: Kleene.None };
        }

        if (token.type === 'get-var') {
            const getVar: GetVar = {
                kind: 'get',
                name: token.value,
                textMappings: [],
                kleene: Kleene.None,
            };
            next();
            while (peek().type === 'transform') {
                next();
                getVar.textMappings.push(expect('identifier').value);
            }
            return getVar;
        }

        if (token.type === 'set-var' || token.type === 'lazy-set-var') {
            const isLazy = token.type === 'lazy-set-var';
            const name = token.value;
            next();
            const value = parseOption();
            return { kind: isLazy ? 'lazy' : 'set', name, value };
        }

        if (token.type === 'identifier') {
            const ref: Ref = { ref: token.value, textMappings: [], kleene: Kleene.None };
            next();
            if (peek().type === 'symbol' && peek().value === '(') {
                next();
                const args: Option[] = [];
                while (peek().type !== 'symbol' || peek().value !== ')') {
                    args.push(parseOption());
                }
                expect('symbol', ')');
                ref.args = args;
            }
            // transformations go after args.
            while (peek().type === 'transform') {
                next();
                ref.textMappings.push(expect('identifier').value);
            }
            return ref;
        }

        if (token.type === 'symbol' && token.value === '[') {
            return parseAnonymousRule();
        }
        if (token.type === 'repeat') {
            // %repeat(atom, integer_or_identifier)
            next();
            expect('symbol', '(');
            const leftAtom = parseOption();
            expect('symbol', ',');

            let repeatOption : Repeat;
            if (peek().type === 'integer') {
                repeatOption = { kind: 'repeat', value: leftAtom, integer: parseInt(peek().value), kleene: Kleene.None }
            } else if (peek().type === 'identifier') {
                repeatOption = { kind: 'repeat', value: leftAtom, variable: peek().value, kleene: Kleene.None };
            } else {
                throw new Error(`Unexpected second parameter in %repeat: ${peek().value}`);
            }
            next();
            expect('symbol', ')');
            return repeatOption;
        }

        throw new Error(`Unexpected token in option: ${token.type} ${token.value}`);
    }

    function parseAnonymousRule(): Ref {
        const anonName = `anonymous-${anonCounter.toString().padStart(4, '0')}`;
        anonCounter++;
        expect('symbol', '[');
        const options = parseRuleOptions(true);
        statements.push({
            type: 'rule',
            name: anonName,
            parameters: [],
            options, resource: true,
            lastChoice: -1
        });
        return { ref: anonName, textMappings: [], kleene: Kleene.None };
    }

    function parseRuleOptions(isAnonymous: boolean): Option[][] {
        let endSymbol: string = ';';
        if (isAnonymous) {
            endSymbol = ']';
        }
        const options: Option[][] = [];
        let currentOption: Option[] = [];

        const ruleError: () => string = () => currentRuleName ? ` in rule "${currentRuleName}"` : '';

        while (true) {
            const token = peek();
            if (
                token.type === 'string'
                || token.type === 'identifier'
                || (token.type === 'symbol' && token.value === '[')
                || token.type === 'code'
                || token.type === 'get-var'
                || token.type === 'set-var'
                || token.type === 'lazy-set-var'
                || token.type === 'silenced'
                || token.type === 'indirection'
                || token.type === 'repeat'
            ) {
                currentOption.push(parseOption());
            } else if (token.type === 'symbol' && token.value === '|') {
                next();
                options.push(currentOption);
                currentOption = [];
            } else if (token.type === 'symbol' && token.value === endSymbol) {
                next();
                options.push(currentOption);
                break;
            } else if (token.type === 'kleene') {
                if (!currentOption.length) {
                    throw new Error(`Kleene token ${token.value} found at beginning of option${ruleError()}.`);
                }
                // .at(-1) after updating to Library to 2022
                let lastOption = currentOption[currentOption.length - 1];
                if (!('kleene' in lastOption)) {
                    if ('value' in lastOption && 'kleene' in lastOption.value) {
                        // allows for var="hello"+
                        lastOption = lastOption.value;
                    } else if (
                        'value' in lastOption
                        && 'value' in lastOption.value
                        && typeof lastOption.value.value === 'object'
                        && 'kleene' in lastOption.value.value
                    ) {
                        // in theory, should continue as long as there is a value...
                        // but this allows for ?var="hello"+
                        lastOption = lastOption.value.value;
                    } else {
                        throw new Error(`Kleene token ${token.value} cannot be used in this position${ruleError()}.`);
                    }
                }
                const kleeneType = (token.value === '+' ? Kleene.Plus : Kleene.Star);
                lastOption.kleene = kleeneType;
                next()
            } else {
                if (!isAnonymous && token.type === 'symbol' && token.value === ':') {
                    throw new Error(`Unexpected second colon${ruleError()}: missing semicolon?`)
                } else if (isAnonymous) {
                    throw new Error(`Unexpected token for anonymous rule${ruleError()}: ${token.type} ${token.value}`);
                } else {
                    throw new Error(`Unexpected token ${token.type} ${token.value}${ruleError()}`);
                }
            }
        }
        return options;
    }

    function parseRule({resource_rule=false}: {resource_rule: boolean}): Rule {
        const name = expect('identifier').value;
        currentRuleName = name;
        const parameters: string[] = [];

        if (peek().type === 'symbol' && peek().value === '(') {
            resource_rule = true; // rules with parameters are resources.
            next();
            while (peek().type !== 'symbol' || peek().value !== ')') {
                parameters.push(expect('identifier').value);
            }
            expect('symbol', ')');
        }

        expect('symbol', ':');
        const options: Option[][] = parseRuleOptions(false);

        currentRuleName = null;
        return { type: 'rule', name, parameters, options, resource: resource_rule, lastChoice: -1 };
    }

    function parseMapping(): TextMapping {
        const name = expect('identifier').value;
        currentRuleName = name;
        expect('symbol', ':');
        const rules = [];

        if (peek().type !== 'string') {
            throw new Error(`Empty mapping ${name} -- must begin with string not ${peek().type}`);
        }

        // until ';'
        while (peek().type !== 'symbol' || peek().value !== ';') {
            const pattern = expect('string').value;
            const mapping_type = expect('mapping');
            if (mapping_type.value === '<->') {
                // bidirectional mapping; - type 2: easy to spot
                const replacement = expect('string').value;
                rules.push({
                    pattern: '^' + pattern + '$',
                    target: '^' + pattern + '$',
                    replacement,
                });
                rules.push({
                    pattern: '^' + replacement + '$',
                    target: '^' + replacement + '$',
                    replacement: pattern,
                });
                continue;
            }
            if (mapping_type.value !== '->') {
                // should not be possible.
                throw new Error(`Unexpected mapping ${mapping_type.value} in mapping ${name}`);
            }

            // type one and type 3 mappings use the same mapping type, so need to look two ahead
            // for a slash.
            const target_or_replacement = expect('string').value;
            if (peek().type !== 'slash') {
                // type 1 "Alice" -> "she" style mapping
                if (pattern !== '_') {
                    // normal
                    rules.push({
                        pattern: '^' + pattern + '$',
                        target: '^' + pattern + '$',
                        replacement: target_or_replacement,
                    });
                } else {
                    // wildcard -- should be last.
                    rules.push({
                        pattern: '^.*$',
                        target: '^.*$',
                        replacement: target_or_replacement,
                    });
                }
            } else {
                // type 3: ".*s$" -> "$"/"es"
                expect('slash', '/');
                const replacement = expect('string').value;
                rules.push({ pattern, target: target_or_replacement, replacement });


            }
        }
        expect('symbol', ';');
        currentRuleName = null;
        return { type: 'textMapping', name, rules };
    }

    function parseStatements(): Statement[] {
        let next_rule_is_resource = false;
        while (peek().type !== 'eof') {
            const token = peek();
            if (token.type === 'identifier') {
                if (
                    tokens[i + 1]?.type === 'symbol' &&
                    tokens[i + 1].value === ':' &&
                    tokens[i + 2]?.type === 'string' &&
                    tokens[i + 3]?.type === 'mapping'
                ) {
                    statements.push(parseMapping());
                } else {
                    statements.push(parseRule({resource_rule: next_rule_is_resource}));
                    next_rule_is_resource = false;
                }
            } else if (token.type === 'resource') {
                next_rule_is_resource = true;
                next();
            } else {
                throw new Error(`Unexpected token: ${token.type} ${token.value}`);
            }
        }

        return statements;
    }
    return parseStatements();
}
