export function scopedEval(code: string, context: Record<string, any>): any {
    const trimmed = code.trim();
    const isExpr = trimmed.startsWith('=');
    let wrappedCode = isExpr
        ? `__RETURN = ${trimmed.slice(1)};`
        : trimmed;

    wrappedCode = `
        try {
            ${wrappedCode}
        } catch (__e) {
            __ERROR = __e;
        }
    `;

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
    Function('with (this) { ' + wrappedCode + ' }').call(proxy);

    if ('__ERROR' in context) {
        const err = context.__ERROR;
        delete context.__ERROR;
        throw err;
    }

    if (isExpr) {
        const result = context.__RETURN;
        delete context.__RETURN;
        return result;
    }

    return null;
}
