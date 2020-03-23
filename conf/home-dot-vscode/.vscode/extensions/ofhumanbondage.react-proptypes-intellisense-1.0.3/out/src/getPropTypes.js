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
const vscode_1 = require("vscode");
const utils_1 = require("./utils");
const getPropTypesFromStatic_1 = require("./getPropTypesFromStatic");
const getPropTypesFromProperty_1 = require("./getPropTypesFromProperty");
const getPropTypesFromPrototype_1 = require("./getPropTypesFromPrototype");
const getComponentTextDocument = (componentUri) => __awaiter(this, void 0, void 0, function* () {
    return vscode_1.workspace.openTextDocument(componentUri);
});
const getComponentName = (componentTextDocument, componentNameLocation) => {
    return componentTextDocument.getText(componentNameLocation);
};
exports.default = (componentUri, componentNameLocation) => __awaiter(this, void 0, void 0, function* () {
    const componentTextDocument = yield getComponentTextDocument(componentUri);
    const componentName = getComponentName(componentTextDocument, componentNameLocation);
    const ast = utils_1.getAst(componentTextDocument.getText());
    if (!ast) {
        return [];
    }
    const componentPropTypesFromStatic = getPropTypesFromStatic_1.default(componentTextDocument, ast, componentName);
    if (componentPropTypesFromStatic.length) {
        return componentPropTypesFromStatic;
    }
    const componentPropTypesFromProperty = getPropTypesFromProperty_1.default(componentTextDocument, ast, componentName);
    if (componentPropTypesFromProperty.length) {
        return componentPropTypesFromProperty;
    }
    const componentPropTypesFromPrototype = getPropTypesFromPrototype_1.default(componentTextDocument, ast, componentName);
    if (componentPropTypesFromPrototype.length) {
        return componentPropTypesFromPrototype;
    }
    return [];
});
//# sourceMappingURL=getPropTypes.js.map