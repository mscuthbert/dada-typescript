export function scopedEvalTwoWay(code: string, context: Record<string, any>): void {
    const handler = {
        has: (): boolean => true, // let everything through
        get: (_: any, key: string): any => context[key],
        set: (_: any, key: string, value: any): boolean => { context[key] = value; return true; },
    };
    const proxy = new Proxy({}, handler);
    Function('with(this) { ' + code + ' }').call(proxy);
}
