import { readFileSync } from 'fs';
import { tokenize } from './tokenizer.ts';
import { parse } from './parser.ts';

const filename = process.argv[2];
if (!filename) {
    console.error('Usage: npm run start -- <filename>');
    process.exit(1);
}

const source = readFileSync(filename, 'utf-8');
const tokens = tokenize(source);
const rules = parse(tokens);

console.dir(rules, { depth: null });
