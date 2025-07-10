export function scopedEval(code: string, context: Record<string, any>): string {
    const trimmed = code.trim();
    const isExpr = trimmed.startsWith('=');
    let wrappedCode = isExpr
        ? `__RETURN = ${trimmed.slice(1)};`
        : trimmed;

    wrappedCode = replaceSpecialOperators(wrappedCode);

    wrappedCode = `
        try {
            ${wrappedCode}
        } catch (__e) {
            __ERROR = __e;
        }
    `;

    context.__Math = Math;
    const handler = {
        has: () => true,
        get: (_: any, key: string) => context[key],
        set: (_: any, key: string, value: any) => {
            context[key] = value;
            return true;
        }
    };

    const proxy = new Proxy({}, handler);

    // Execute the constructed function body in the proxy context
    try {
        Function('with (this) { ' + wrappedCode + ' }').call(proxy);
    } catch (e) {
        throw new Error(`Unexpected error occurred ${e} for ${wrappedCode}`);
    }

    delete context.__Math;
    if ('__ERROR' in context) {
        const err = context.__ERROR;
        delete context.__ERROR;
        throw err;
    }

    // console.log('out', JSON.stringify(context));
    if (isExpr) {
        const result = context.__RETURN;
        delete context.__RETURN;
        // "A return statement consists of a '=' sign followed by an expression.
        // When the statement is executed, the expression is evaluated
        // and its result *converted to a string* and returned."
        return result.toString();
    }

    return '';
}

type RangeExpression = {
    left: string;
    right: string;
    startIndex: number;
    endIndex: number;
    operator: '..' | '<<' | '>>';
};

function extractSpecialOperators(input: string, operator: '..' | '<<' | '>>'): RangeExpression[] {
    const results: RangeExpression[] = [];
    const pattern = new RegExp(escapeRegExp(operator), 'g');
    let match: RegExpExecArray | null;

    // Identify all string ranges to ignore
    const stringRanges: [number, number][] = [];
    const stringPattern = /"(?:[^"\\]|\\.)*"/g;
    let strMatch: RegExpExecArray | null;
    while ((strMatch = stringPattern.exec(input))) {
        stringRanges.push([strMatch.index, strMatch.index + strMatch[0].length]);
    }

    function isInsideString(index: number): boolean {
        return stringRanges.some(([start, end]) => index >= start && index < end);
    }

    while ((match = pattern.exec(input))) {
        const idx = match.index;

        if (isInsideString(idx)) continue;

        const left = extractExprLeft(input, idx);
        const right = extractExprRight(input, idx + operator.length);

        if (left && right) {
            results.push({
                left: left.expr,
                right: right.expr,
                startIndex: left.start,
                endIndex: right.end,
                operator
            });
        }
    }

    return results;
}
function extractExprLeft(str: string, from: number): { expr: string, start: number } | null {
    let i = from - 1;

    while (i >= 0 && /\s/.test(str[i])) i--;

    if (/\d/.test(str[i])) {
        const end = i;
        while (i >= 0 && /\d/.test(str[i])) i--;
        return { expr: str.slice(i + 1, end + 1), start: i + 1 };
    }

    if (/[a-zA-Z_]/.test(str[i])) {
        const end = i;
        while (i >= 0 && /[a-zA-Z0-9_]/.test(str[i])) i--;
        return { expr: str.slice(i + 1, end + 1), start: i + 1 };
    }

    if (str[i] === ')') {
        const end = i;
        let depth = 1;
        i--;
        while (i >= 0 && depth > 0) {
            if (str[i] === ')') depth++;
            else if (str[i] === '(') depth--;
            i--;
        }
        if (depth === 0) {
            return { expr: str.slice(i + 1, end + 1), start: i + 1 };
        }
    }

    return null;
}

function extractExprRight(str: string, from: number): { expr: string, end: number } | null {
    let i = from;

    while (i < str.length && /\s/.test(str[i])) i++;

    if (/\d/.test(str[i])) {
        const start = i;
        while (i < str.length && /\d/.test(str[i])) i++;
        return { expr: str.slice(start, i), end: i };
    }

    if (/[a-zA-Z_]/.test(str[i])) {
        const start = i;
        while (i < str.length && /[a-zA-Z0-9_]/.test(str[i])) i++;
        return { expr: str.slice(start, i), end: i };
    }

    if (str[i] === '(') {
        const start = i;
        let depth = 1;
        i++;
        while (i < str.length && depth > 0) {
            if (str[i] === '(') depth++;
            else if (str[i] === ')') depth--;
            i++;
        }
        if (depth === 0) {
            return { expr: str.slice(start, i), end: i };
        }
    }

    return null;
}

function escapeRegExp(str: string): string {
    return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function replaceSpecialOperators(input: string): string {
    const allOperators: RangeExpression[] = [];
    for (const op of ['..', '<<', '>>'] as const) {
        allOperators.push(...extractSpecialOperators(input, op));
    }

    allOperators.sort((a, b) => b.startIndex - a.startIndex);

    let result = input;
    for (const { left, right, startIndex, endIndex, operator } of allOperators) {
        let replacement: string;
        if (operator === '<<') {
            replacement = `__Math.min(${left}, ${right})`;
        } else if (operator === '>>') {
            replacement = `__Math.max(${left}, ${right})`;
        } else {
            replacement = `(__Math.floor(__Math.random() * (${right} - ${left} + 1)) + ${left})`;
        }
        result = result.slice(0, startIndex) + replacement + result.slice(endIndex);
    }

    return result;
}
