import type { Token } from './tokenizer.ts';

export interface Rule {
    type: 'rule';
    name: string;
    parameters: string[];
    options: Option[][];
    lastChoice?: number;
}

export interface Transform {
    type: 'transform';
    name: string;
    rules: { pattern: string; target: string; replacement: (string|((...args: any[]) => string)); }[];
}

export interface Ref {
    ref: string;
    transforms: string[];
    args?: Option[];
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
    transforms: string[];
}

export interface SilencedOption {
    kind: 'silenced';
    value: Option;
}

export type Option = string | Ref | SetVar | LazySetVar | GetVar | SilencedOption;

export type Statement = Rule | Transform;

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
            throw new Error(`Expected ${type} ${value ?? ''}, got ${token.type} ${token.value}${currentRuleName ? ` (in rule: ${currentRuleName})` : ''}`);
        }
        return token;
    }

    function parseOption(): Option {
        const token = peek();

        if (token.type === 'string') {
            next();
            return token.value;
        }

        if (token.type === 'silenced') {
            next();
            const value = parseOption();
            return { kind: 'silenced', value: value };
        }

        if (token.type === 'get-var') {
            const getVar: GetVar = { kind: 'get', name: token.value, transforms: [] };
            next();
            while (peek().type === 'greater') {
                next();
                getVar.transforms.push(expect('identifier').value);
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
            const ref: Ref = { ref: token.value, transforms: [] };
            next();
            while (peek().type === 'greater') {
                next();
                ref.transforms.push(expect('identifier').value);
            }
            if (peek().type === 'symbol' && peek().value === '(') {
                next();
                const args: Option[] = [];
                while (peek().type !== 'symbol' || peek().value !== ')') {
                    args.push(parseOption());
                }
                expect('symbol', ')');
                ref.args = args;
            }
            return ref;
        } else if (token.type === 'symbol' && token.value === '[') {
            return parseAnonymousRule();
        } else {
            throw new Error(`Unexpected token in option: ${token.type} ${token.value}`);
        }
    }

    function parseAnonymousRule(): Ref {
        const anonName = `anonymous-${anonCounter.toString().padStart(4, '0')}`;
        anonCounter++;
        expect('symbol', '[');

        const options: Option[][] = [];
        let currentOption: Option[] = [];

        while (true) {
            const token = peek();
            if (
                token.type === 'string' ||
                token.type === 'identifier' ||
                (token.type === 'symbol' && token.value === '[')
            ) {
                currentOption.push(parseOption());
            } else if (token.type === 'symbol' && token.value === '|') {
                next();
                options.push(currentOption);
                currentOption = [];
            } else if (token.type === 'symbol' && token.value === ']') {
                next();
                options.push(currentOption);
                break;
            } else {
                throw new Error(`Unexpected token in anonymous rule: ${token.type} ${token.value}`);
            }
        }

        statements.push({ type: 'rule', name: anonName, parameters: [], options });
        return { ref: anonName, transforms: [] };
    }

    function parseRule(): Rule {
        const name = expect('identifier').value;
        currentRuleName = name;
        const parameters: string[] = [];

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
            if (
                token.type === 'string'
                || token.type === 'identifier'
                || (token.type === 'symbol' && token.value === '[')
                || token.type === 'get-var'
                || token.type === 'set-var'
                || token.type === 'lazy-set-var'
                || token.type === 'silenced'
            ) {
                currentOption.push(parseOption());
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

    function parseMapping(): Transform {
        const name = expect('identifier').value;
        currentRuleName = name;
        expect('symbol', ':');
        const rules = [];

        if (peek().type !== 'string') {
            throw new Error(`Empty mapping ${name} -- must begin with string not ${peek().type}`);
        }

        // until ';'
        while (peek().type !== 'symbol') {
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

            // type one and type 3 mapping use the same mapping type, so need to look two ahead
            // for a slash.
            const target_or_replacement = expect('string').value;
            if (peek().type !== 'slash') {
                // type 1 "Alice" -> "she" style mapping
                rules.push({
                    pattern: '^' + pattern + '$',
                    target: '^' + pattern + '$',
                    replacement: target_or_replacement,
                });
            } else {
                // type 3: ".*s$" -> "$"/"es"
                expect('slash', '/');
                const replacement = expect('string').value;
                rules.push({ pattern, target: target_or_replacement, replacement });
            }
        }
        expect('symbol', ';');
        currentRuleName = null;
        return { type: 'transform', name, rules };
    }

    function parseStatements(): Statement[] {
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
                    statements.push(parseRule());
                }
            } else if (token.type === 'directive') {
                while (peek().type !== 'symbol' || peek().value !== ';') {
                    next();
                }
                next();
            } else {
                throw new Error(`Unexpected token: ${token.type} ${token.value}`);
            }
        }

        return statements;
    }

    return parseStatements();
}
