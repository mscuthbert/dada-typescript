import { readFileSync } from 'fs';
import { tokenize } from './tokenizer.ts';

const filename = process.argv[2];
if (!filename) {
  console.error('Usage: npm start -- <filename>');
  process.exit(1);
}

const source = readFileSync(filename, 'utf-8');
const tokens = tokenize(source);
console.log(tokens);
