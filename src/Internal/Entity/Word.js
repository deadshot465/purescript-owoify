export const _matchAll = (regex) => (s) => {
    return Array.from(s.matchAll(regex));
};
