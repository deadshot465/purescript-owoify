"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports._matchAll = void 0;
const _matchAll = (regex) => (s) => {
    return Array.from(s.matchAll(regex));
};
exports._matchAll = _matchAll;
