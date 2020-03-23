"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const babel_traverse_1 = require("babel-traverse");
const vscode_1 = require("vscode");
const getPropTypes_1 = require("./getPropTypes");
const utils_1 = require("./utils");
class PropTypesCompletionItemProvider {
    getPropTypesFromJsxTag(jsxOpeningElement) {
        return jsxOpeningElement.attributes.map((jsxAttribute) => {
            if ('argument' in jsxAttribute) {
                return '...={}';
            }
            return `${jsxAttribute.name.name}={}`;
        });
    }
    getStartTagPosition(jsxOpeningElement) {
        return new vscode_1.Position(jsxOpeningElement.loc.start.line - 1, jsxOpeningElement.loc.start.column + 1);
    }
    isReactComponent(jsxOpeningElement) {
        const nameOfJsxTag = jsxOpeningElement.name.name;
        return nameOfJsxTag[0] === nameOfJsxTag[0].toUpperCase();
    }
    isCursorInJsxOpeningElement(cursorPosition, jsxOpeningElement) {
        return cursorPosition > jsxOpeningElement.start && cursorPosition < jsxOpeningElement.end;
    }
    isCursorInJsxAttribute(cursorPosition, node, scope) {
        let result = false;
        babel_traverse_1.default(node, {
            JSXAttribute(path) {
                const jsxAttribute = path.node;
                if (cursorPosition > jsxAttribute.start && cursorPosition < jsxAttribute.end) {
                    result = true;
                }
            }
        }, scope);
        return result;
    }
    getJsxOpeningElement(document, position) {
        const documentText = document.getText();
        const cursorPosition = document.offsetAt(position);
        const ast = utils_1.getAst(documentText);
        if (!ast) {
            return undefined;
        }
        let result;
        babel_traverse_1.default(ast, {
            JSXOpeningElement: path => {
                const jsxOpeningElement = path.node;
                const isCursorInJsxOpeningElement = this.isCursorInJsxOpeningElement(cursorPosition, jsxOpeningElement);
                const isCursorInJsxAttribute = this.isCursorInJsxAttribute(cursorPosition, jsxOpeningElement, path.scope);
                if (isCursorInJsxOpeningElement && !isCursorInJsxAttribute) {
                    result = jsxOpeningElement;
                }
            }
        });
        return result;
    }
    provideCompletionItems(document, position) {
        return __awaiter(this, void 0, void 0, function* () {
            const jsxOpeningElement = this.getJsxOpeningElement(document, position);
            if (!jsxOpeningElement || !this.isReactComponent(jsxOpeningElement)) {
                return [];
            }
            const startTagPosition = this.getStartTagPosition(jsxOpeningElement);
            const tagDefinition = yield utils_1.getDefinition(document.uri, startTagPosition);
            if (!tagDefinition) {
                return [];
            }
            const parsedPropTypes = this.getPropTypesFromJsxTag(jsxOpeningElement);
            const propTypes = (yield getPropTypes_1.default(tagDefinition.uri, tagDefinition.range)).filter(propType => parsedPropTypes.indexOf(propType.insertText) === -1);
            return propTypes;
        });
    }
}
exports.default = PropTypesCompletionItemProvider;
//# sourceMappingURL=PropTypesCompletionItemProvider.js.map