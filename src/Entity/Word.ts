export const _matchAll = (regex: RegExp) => (s: string) => {
    return Array.from(s.matchAll(regex));
};