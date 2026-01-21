/*
 * Tokenizer for the TypeScript PB/Dada parser.
 *
 * Copyright (c) 2025-26 Michael Scott Asato Cuthbert
 * BSD License: Some Rights Reserved
 */
const DEBUG = false;

export type TokenBase = {
    line: number;
    column: number;
};

export type Token = TokenBase & (
    | { type: 'identifier'; value: string }  // my-verb
    | { type: 'string'; value: string }  // "hello"
    | { type: 'code'; value: string }  // in { ... }
    | { type: 'symbol'; value: string }
    | { type: 'kleene'; value: '+' | '*' }
    | { type: 'mapping'; value: '->' | '<->' }
    | { type: 'slash'; value: '/' }
    | { type: 'transform'; value: '>' }
    | { type: 'silenced'; value: '?' }
    | { type: 'indirection'; value: '@' }
    | { type: 'get-var'; value: string }
    | { type: 'set-var'; value: string }
    | { type: 'lazy-set-var'; value: string }
    | { type: 'resource'; value: '%resource' }
    | { type: 'repeat'; value: '%repeat' }
    | { type: 'integer'; value: string }
    | { type: 'eof'; value: '<eof>' }
);

function isDigit(ch: string): boolean {
    return ch >= '0' && ch <= '9';
}

export function tokenize(input: string): Token[] {
    const tokens: Token[] = [];
    let i = 0;
    let line = 1;
    let column = 1;

    function advance(n: number = 1): void {
        for (let j = 0; j < n; j++) {
            if (input[i] === '\n') {
                line++;
                column = 1;
            } else {
                column++;
            }
            i++;
        }
    }

    function skipWhitespaceAndComments(): void {
        while (i < input.length) {
            if (/\s/.test(input[i])) {
                advance();
            } else if (input[i] === '/' && input[i + 1] === '/') {
                while (i < input.length && input[i] !== '\n') {
                    advance();
                }
            } else if (input[i] === '/' && input[i + 1] === '*') {
                advance(2);
                while (i < input.length && !(input[i] === '*' && input[i + 1] === '/')) {
                    advance();
                }
                if (i < input.length) {
                    advance(2);
                }
            } else {
                break;
            }
        }
    }

    function match(regex: RegExp): string | null {
        const matched = input.slice(i).match(regex);
        if (matched && matched.index === 0) {
            advance(matched[0].length);
            return matched[0];
        }
        return null;
    }

    function addToken<T extends Token['type']>(
        type: T,
        value: Extract<Token, { type: T }>['value']
    ): void {
        tokens.push({ type, value, line, column } as Token);
    }

    function extractQuote(): string {
        let str = '';
        advance();
        while (i < input.length && input[i] !== '"') {
            if (input[i] === '\\') {
                const esc = input[i + 1];
                if (esc === '"') {
                    str += '"';
                    advance(2);
                } else if (esc === '\\') {
                    str += '\\';
                    advance(2);
                } else if (esc === 'n') {
                    str += '\n'; // newline
                    advance(2);
                } else if (esc === 't') {
                    str += '\t'; // tab
                    advance(2);
                } else if (esc === 'v') {
                    str += '\v'; // vertical tab (don't use)
                    advance(2);
                } else if (esc === 'b') {
                    str += '\b'; // backspace (don't use)
                    advance(2);
                } else if (esc === 'r') {
                    str += '\r'; // Carriage return w/o newline (don't use)
                    advance(2);
                } else if (esc === 'f') {
                    str += '\f'; // form feed
                    advance(2);
                } else if (esc === 'a') {
                    str += '\u0007'; // Javascript does not support \a will not work.
                    advance(2);
                } else {
                    str += input[i];
                    advance();
                }
            } else {
                str += input[i];
                advance();
            }
        }
        if (input[i] === '"') {
            advance();
            return str;
        } else {
            throw new Error(`Tokenizer: Unterminated string at line ${line}, column ${column}`);
        }
    }

    while (i < input.length) {
        skipWhitespaceAndComments();
        if (i >= input.length) {
            break;
        }

        if (input[i] === '"') {
            const str = extractQuote();
            addToken('string', str);
            continue;
        }

        if (input[i] === '{') {
            // console.log('entered code block');
            const codeStartLine = line;
            const codeStartColumn = column;
            let codeBlock = '';
            advance();
            let depth = 1;
            while (i < input.length && depth) {
                // console.log(i);
                if (input[i] === '{') {
                    depth++;
                    codeBlock += '{';
                    advance()
                } else if (input[i] === '}') {
                    depth--;
                    if (depth) {
                        codeBlock += '}'
                    }
                    advance();
                } else if (input[i] === '"') {
                    codeBlock += '"' + extractQuote() + '"'; // this way quotes can use { and } in them.
                } else {
                    codeBlock += input[i];
                    advance();
                }
            }
            if (depth !== 0) {
                throw new Error(
                    `Tokenizer: Unterminated code block starting at line ${codeStartLine}, column ${codeStartColumn}`
                );
            }
            addToken('code', codeBlock);
            // console.log(`exited code block ${codeBlock}`);
            continue;
        }

        if (isDigit(input[i])) {
            // used only as a value to the %repeat directive.
            let integer = ''
            while (i < input.length && isDigit(input[i])) {
                integer += input[i];
                advance();  // i++
            }
            addToken('integer', integer);
            continue;
        }

        // this use of startsWith means "continues after i with..."
        if (input.startsWith('->', i)) {
            advance(2);
            addToken('mapping', '->');
            continue;
        }

        if (input.startsWith('<->', i)) {
            advance(3);
            addToken('mapping', '<->');
            continue;
        }

        if (input.startsWith('%resource', i)) {
            advance('%resource'.length);
            addToken('resource', '%resource');
            continue;
        }

        if (input.startsWith('%repeat', i)) {
            advance('%repeat'.length);
            addToken('repeat', '%repeat');
            continue;
        }

        if (input[i] === '>') {
            advance();
            addToken('transform', '>');
            continue;
        }

        if (input[i] === '?') {
            advance();
            addToken('silenced', '?');
            continue;
        }

        if (input[i] === '@') {
            advance();
            addToken('indirection', '@');
            continue;
        }

        if (input[i] === '/') {
            advance();
            addToken('slash', '/');
            continue;
        }

        if (input[i] === '+') {
            advance();
            addToken('kleene', '+');
            continue;
        }
        if (input[i] === '*') {
            advance();
            addToken('kleene', '*');
            continue;
        }

        if (input[i] === '$') {
            advance();
            const name = match(/^[\p{L}_][\p{L}0-9_-]*/u);
            if (!name) {
                throw new Error(`Tokenizer: Invalid variable name after $ at line ${line}, column ${column}`);
            }
            addToken('get-var', name);
            continue;
        }
        const setVar = match(/^[\p{L}_][\p{L}0-9_-]*(=|<<)/u);
        if (setVar) {
            const name = setVar.endsWith('=')
                ? setVar.slice(0, -1)
                : setVar.slice(0, -2);
            addToken(setVar.endsWith('=') ? 'set-var' : 'lazy-set-var', name);
            continue;
        }

        const identifier = match(/^[\p{L}_][\p{L}0-9_-]*/u);
        if (identifier) {
            addToken('identifier', identifier);
            continue;
        }

        const symbol = match(/^[;,:|(){}[\]]/);
        if (symbol) {
            addToken('symbol', symbol);
            continue;
        }
        const suspiciousPipeString = tokens.find(t =>
            t.type === 'string' && /^\s*\|\s*$/.test(t.value)
        );
        const hint = suspiciousPipeString
            ? `\nPossible missing quotation marks before line ${suspiciousPipeString.line}, `
                + `column ${suspiciousPipeString.column}\n(suspicious string: "${suspiciousPipeString.value}")\n`
            : `Last tokens:\n${tokens.slice(-5).map(t => t.value + '\n')}\n`;

        const debug_hint = DEBUG ?  '\n---------\n'
            + (tokens.filter(t => t.type === 'string').map(t => t.value + '\n'))
            : '';

        throw new Error(
            `Tokenizer: Unexpected character at line ${line}, column ${column}: '${input[i]}'\n`
            + hint
            + debug_hint
        );
    }

    addToken('eof', '<eof>');
    return tokens;
}
