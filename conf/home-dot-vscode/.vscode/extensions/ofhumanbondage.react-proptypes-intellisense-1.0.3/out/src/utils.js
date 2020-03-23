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
const babylon_1 = require("babylon");
const prettier = require("prettier");
const vscode_1 = require("vscode");
const path_1 = require("path");
exports.getAst = (fileText) => {
    try {
        return babylon_1.parse(fileText, {
            sourceType: 'module',
            plugins: [
                'jsx',
                'flow',
                'doExpressions',
                'objectRestSpread',
                'decorators',
                'classProperties',
                'exportExtensions',
                'asyncGenerators',
                'functionBind',
                'functionSent',
                'dynamicImport'
            ]
        });
    }
    catch (error) {
        return undefined;
    }
};
exports.sourceLocationToRange = (sourceLocation) => {
    return new vscode_1.Range(new vscode_1.Position(sourceLocation.start.line - 1, sourceLocation.start.column), new vscode_1.Position(sourceLocation.end.line - 1, sourceLocation.end.column));
};
const PRETTIER_OPTIONS = {
    tabWidth: 4,
    semi: false,
    printWidth: 40
};
exports.formatJSString = (jsString) => {
    return prettier.format(jsString, PRETTIER_OPTIONS);
};
exports.isRequiredPropType = (propType) => {
    const propTypeSeparatedByDot = propType.split('.');
    return propTypeSeparatedByDot[propTypeSeparatedByDot.length - 1] === 'isRequired';
};
const isPathToTypingFile = (path) => path_1.basename(path).endsWith('.d.ts');
exports.getDefinition = (documentUri, position) => __awaiter(this, void 0, void 0, function* () {
    const definitions = yield vscode_1.commands.executeCommand('vscode.executeImplementationProvider', documentUri, position);
    const definitionsWithoutTypings = definitions.filter((definition) => !isPathToTypingFile(definition.uri.path));
    const length = definitionsWithoutTypings.length;
    if (!length) {
        return undefined;
    }
    return definitionsWithoutTypings[length - 1];
});
//# sourceMappingURL=utils.js.map