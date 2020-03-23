"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const babel_traverse_1 = require("babel-traverse");
const getCompletionItems_1 = require("./getCompletionItems");
exports.default = (componentTextDocument, ast, componentName) => {
    let scope;
    let propTypes;
    babel_traverse_1.default(ast, {
        ExpressionStatement(path) {
            const expression = path.node.expression;
            const left = expression.left;
            const leftObject = left.object;
            const leftProperty = left.property;
            const right = expression.right;
            if (leftObject.name === componentName && leftProperty.name === 'propTypes') {
                propTypes = right;
                scope = path.scope;
            }
        }
    });
    if (!propTypes || !scope) {
        return [];
    }
    return getCompletionItems_1.default(componentTextDocument, propTypes, scope);
};
//# sourceMappingURL=getPropTypesFromProperty.js.map