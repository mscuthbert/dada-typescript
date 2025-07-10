/*
 * Tokenizer for the TypeScript PB/Dada parser.
 *
 * Copyright (c) 2025 Michael Scott Asato Cuthbert
 * BSD License: Some Rights Reserved
 */
export type Token =
    | { type: 'identifier'; value: string }
    | { type: 'string'; value: string }
    | { type: 'code'; value: string }
    | { type: 'symbol'; value: string }
    | { type: 'kleene'; value: '+'|'*' }
    | { type: 'mapping'; value: '->'|'<->' }
    | { type: 'slash'; value: '/' }
    | { type: 'transform'; value: '>' }
    | { type: 'silenced'; value: '?' }
    | { type: 'indirection'; value: '@' }
    | { type: 'get-var'; value: string }
    | { type: 'set-var'; value: string }
    | { type: 'lazy-set-var'; value: string }
    | { type: 'resource'; value: '%resource' }
    | { type: 'eof'; value: '<eof>' };

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
            throw new Error(`Unterminated string at line ${line}, column ${column}`);
        }
    }

    while (i < input.length) {
        skipWhitespaceAndComments();
        if (i >= input.length) {
            break;
        }

        if (input[i] === '"') {
            const str = extractQuote();
            tokens.push({ type: 'string', value: str });
            continue;
        }

        if (input[i] === '{') {
            // console.log('entered code block');
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
            tokens.push({ type: 'code', value: codeBlock });
            // console.log(`exited code block ${codeBlock}`);
            continue;
        }

        // this use of startsWith means "continues after i with..."
        if (input.startsWith('->', i)) {
            advance(2);
            tokens.push({ type: 'mapping', value: '->' });
            continue;
        }

        if (input.startsWith('<->', i)) {
            advance(3);
            tokens.push({ type: 'mapping', value: '<->' });
            continue;
        }

        if (input.startsWith('%resource', i)) {
            advance('%resource'.length);
            tokens.push({ type: 'resource', value: '%resource' });
            continue;
        }

        if (input[i] === '>') {
            advance();
            tokens.push({ type: 'transform', value: '>' });
            continue;
        }

        if (input[i] === '?') {
            advance();
            tokens.push({ type: 'silenced', value: '?' });
            continue;
        }

        if (input[i] === '@') {
            advance();
            tokens.push({ type: 'indirection', value: '@' });
            continue;
        }

        if (input[i] === '/') {
            advance();
            tokens.push({ type: 'slash', value: '/' });
            continue;
        }

        if (input[i] === '+') {
            advance();
            tokens.push({ type: 'kleene', value: '+' });
            continue;
        }
        if (input[i] === '*') {
            advance();
            tokens.push({ type: 'kleene', value: '*' });
            continue;
        }

        if (input[i] === '$') {
            advance();
            const name = match(/^[a-zA-Z_][\w-]*/);
            if (!name) {
                throw new Error(`Invalid variable name after $ at line ${line}, column ${column}`);
            }
            tokens.push({ type: 'get-var', value: name });
            continue;
        }

        const setVar = match(/^[a-zA-Z_][\w-]*(=|<<)/);
        if (setVar) {
            const name = setVar.endsWith('=')
                ? setVar.slice(0, -1)
                : setVar.slice(0, -2);
            tokens.push({
                type: setVar.endsWith('=') ? 'set-var' : 'lazy-set-var',
                value: name
            });
            continue;
        }

        const identifier = match(/^[a-zA-Z_][\w-]*/);
        if (identifier) {
            tokens.push({ type: 'identifier', value: identifier });
            continue;
        }

        const symbol = match(/^[;:|(){}[\]]/);
        if (symbol) {
            tokens.push({ type: 'symbol', value: symbol });
            continue;
        }

        throw new Error(`Unexpected character at line ${line}, column ${column}: '${input[i]}'`);
    }

    tokens.push({ type: 'eof', value: '<eof>' });
    return tokens;
}
