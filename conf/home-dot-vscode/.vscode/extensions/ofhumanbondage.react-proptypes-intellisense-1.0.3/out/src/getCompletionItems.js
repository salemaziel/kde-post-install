"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const babel_traverse_1 = require("babel-traverse");
const utils_1 = require("./utils");
const MOVE_CURSOR_TO_LEFT = {
    title: 'cursorMove',
    command: 'cursorMove',
    arguments: [
        {
            to: 'left'
        }
    ]
};
const getMinimalPropTypeDetail = (propTypeValue) => {
    const separatedPropTypeValue = propTypeValue.split(/\(|\)/g);
    if (separatedPropTypeValue.length > 2) {
        return `${separatedPropTypeValue[0]}(...)${separatedPropTypeValue[separatedPropTypeValue.length - 1]}`;
    }
    return propTypeValue;
};
const getMarkdownString = (str) => {
    return new vscode_1.MarkdownString().appendCodeblock(utils_1.formatJSString(str));
};
const getCompletionItem = (objectProperty, componentTextDocument) => {
    const objectPropertyName = objectProperty.key.name;
    const objectPropertyValue = componentTextDocument.getText(utils_1.sourceLocationToRange(objectProperty.value.loc));
    const propTypeName = `${objectPropertyName}${utils_1.isRequiredPropType(objectPropertyValue) ? '' : '?'}`;
    const detail = `(property) ${objectPropertyName}: ${getMinimalPropTypeDetail(objectPropertyValue)}`;
    const documentation = getMarkdownString(objectPropertyValue);
    const completionItem = new vscode_1.CompletionItem(propTypeName, vscode_1.CompletionItemKind.Field);
    completionItem.sortText = ''; // move on the top of the list
    completionItem.insertText = `${objectPropertyName}={}`;
    completionItem.command = MOVE_CURSOR_TO_LEFT;
    completionItem.detail = detail;
    completionItem.documentation = documentation;
    return completionItem;
};
exports.default = (componentTextDocument, obj, scope) => {
    const result = [];
    babel_traverse_1.default(obj, {
        ObjectProperty: path => {
            // without inner property
            if (path.parent === obj) {
                result.push(getCompletionItem(path.node, componentTextDocument));
            }
        }
    }, scope);
    return result;
};
//# sourceMappingURL=getCompletionItems.js.map