/*
 * CLI running for the TypeScript PB/Dada tokenizer.
 *
 * Copyright (c) 2025 Michael Scott Asato Cuthbert
 * BSD License: Some Rights Reserved
 */
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
