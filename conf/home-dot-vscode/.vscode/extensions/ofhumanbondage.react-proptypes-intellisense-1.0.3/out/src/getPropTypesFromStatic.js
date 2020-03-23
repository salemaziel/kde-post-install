"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const babel_traverse_1 = require("babel-traverse");
const getCompletionItems_1 = require("./getCompletionItems");
exports.default = (componentTextDocument, ast, componentName) => {
    let component;
    let scope;
    let propTypes;
    babel_traverse_1.default(ast, {
        ClassDeclaration(path) {
            if (path.node.id.name === componentName) {
                component = path.node;
                scope = path.scope;
            }
        }
    });
    babel_traverse_1.default(component, {
        ClassProperty(path) {
            if (path.node.key.name === 'propTypes') {
                propTypes = path.node.value;
            }
        }
    }, scope);
    if (!propTypes) {
        return [];
    }
    return getCompletionItems_1.default(componentTextDocument, propTypes, scope);
};
//# sourceMappingURL=getPropTypesFromStatic.js.map