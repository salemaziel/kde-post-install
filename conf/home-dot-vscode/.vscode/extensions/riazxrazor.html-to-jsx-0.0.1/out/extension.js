'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const JSXConvertor_1 = require("./JSXConvertor");
function activate(context) {
    let disposable = vscode.commands.registerTextEditorCommand('extension.convertHTMLtoJSX', () => {
        let editor = vscode.window.activeTextEditor;
        if (!editor) {
            return;
        }
        let selection = editor.selection;
        let range = new vscode.Range(selection.start.line, selection.start.character, selection.end.line, selection.end.character);
        let text = editor.document.getText(selection);
        const jsxConverter = new JSXConvertor_1.default();
        let newString = jsxConverter.convert(text);
        editor.edit(function (editBuilder) {
            editBuilder.replace(range, newString);
        });
    });
    context.subscriptions.push(disposable);
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map