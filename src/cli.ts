import { readFileSync } from 'fs';
import { tokenize } from './tokenizer.ts';
import { parse, type Statement } from './parser.ts';
import { generate } from './generator.ts';

const filename = process.argv[2];
if (!filename) {
    console.error('Usage: npm start -- <file.pb> [--start ruleName]');
    process.exit(1);
}

// Support optional --start ruleName argument
let startRule: string | undefined;
const startIndex = process.argv.indexOf('--start');
if (startIndex !== -1 && process.argv[startIndex + 1]) {
    startRule = process.argv[startIndex + 1];
}

const input = readFileSync(filename, 'utf8');
const tokens = tokenize(input);
const statements: Statement[] = parse(tokens);

const entry: string = startRule ?? ((): string => {
    const first = statements.find(s => s.type === 'rule' && !s.resource);
    if (!first || first.type !== 'rule') {
        console.error('No rules found in input.');
        process.exit(1);
    }
    return first.name;
})();

console.log(generate(statements, entry));
