"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
//if a workspace folder contains another, what we need is to return the out most one
function getOutmostWorkspaceURI(folderURI, folderURIs) {
    let includedInURIs = folderURIs.filter(shorterURI => folderURI.startsWith(shorterURI));
    includedInURIs.sort((a, b) => a.length - b.length);
    return includedInURIs[0];
}
exports.getOutmostWorkspaceURI = getOutmostWorkspaceURI;
function getExtension(filePath) {
    return path.extname(filePath).slice(1).toLowerCase();
}
exports.getExtension = getExtension;
function generateGlobPatternFromExtensions(extensions) {
    if (extensions.length > 1) {
        return '**/*.{' + extensions.join(',') + '}';
    }
    else if (extensions.length === 1) {
        return '**/*.' + extensions[0];
    }
    return undefined;
}
exports.generateGlobPatternFromExtensions = generateGlobPatternFromExtensions;
function getTimeMarker() {
    let date = new Date();
    return '['
        + String(date.getHours())
        + ':'
        + String(date.getMinutes()).padStart(2, '0')
        + ':'
        + String(date.getSeconds()).padStart(2, '0')
        + '] ';
}
exports.getTimeMarker = getTimeMarker;
//# sourceMappingURL=util.js.map