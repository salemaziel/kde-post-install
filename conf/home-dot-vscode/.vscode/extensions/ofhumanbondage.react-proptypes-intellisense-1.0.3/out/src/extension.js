"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const PropTypesCompletionItemProvider_1 = require("./PropTypesCompletionItemProvider");
function activate() {
    const propTypesCompletionItemProvider = new PropTypesCompletionItemProvider_1.default();
    vscode_1.languages.registerCompletionItemProvider(['javascript', 'javascriptreact'], propTypesCompletionItemProvider);
}
exports.activate = activate;
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map