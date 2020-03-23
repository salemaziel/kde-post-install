"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const simple_selector_1 = require("../common/simple-selector");
const forward_scanner_1 = require("../common/forward-scanner");
const path = require("path");
const file_1 = require("../../libs/file");
const vscode_uri_1 = require("vscode-uri");
class JSXSimpleSelectorScanner extends forward_scanner_1.ForwardScanner {
    async scan() {
        let inExpression = false;
        let attributeValue = this.readWholeWord();
        if (!attributeValue) {
            return null;
        }
        // Module CSS, e.g. `className={style.className}`.
        if (this.peek() === '.') {
            this.read();
            return this.scanModuleCSS(attributeValue);
        }
        // Module CSS, e.g. `className={style['class-name']}`.
        if ((this.peek() === '"' || this.peek() === '\'') && this.peekSkipWhiteSpaces(1) === '[') {
            this.readUntil(['[']);
            return this.scanModuleCSS(attributeValue);
        }
        let [untilChar] = this.readUntil(['<', '\'', '"', '`']);
        // Compare to `html-scanner`, here should ignore `<tagName>`.
        if (!untilChar || untilChar === '<') {
            return null;
        }
        this.skipWhiteSpaces();
        if (this.peek() !== '=') {
            // Assume it's in `className={...[HERE]...}` or `class="..."`
            [untilChar] = this.readUntil(['<', '{', '}']);
            if (!untilChar || untilChar !== '{') {
                return null;
            }
            inExpression = true;
        }
        this.skipWhiteSpaces();
        if (this.read() !== '=') {
            return null;
        }
        this.skipWhiteSpaces();
        let attributeName = this.readWord();
        if (attributeName === 'className' || attributeName === 'class' || attributeName === 'id' && !inExpression) {
            let raw = (attributeName === 'id' ? '#' : '.') + attributeValue;
            return simple_selector_1.SimpleSelector.create(raw);
        }
        return null;
    }
    async scanModuleCSS(attributeValue) {
        let moduleVariable = this.readWord();
        if (!moduleVariable) {
            return null;
        }
        let modulePath = this.getImportedPathFromVariableName(moduleVariable);
        if (modulePath) {
            let fullPath = path.resolve(path.dirname(vscode_uri_1.default.parse(this.document.uri).fsPath), modulePath);
            if (await file_1.fileExists(fullPath)) {
                return simple_selector_1.SimpleSelector.create('.' + attributeValue, fullPath);
            }
        }
        return simple_selector_1.SimpleSelector.create('.' + attributeValue);
    }
    getImportedPathFromVariableName(nameToMatch) {
        let re = /import\s+(\w+)\s+from\s+(['"])(.+?)\2/g;
        let match;
        while (match = re.exec(this.text)) {
            let name = match[1];
            if (name === nameToMatch) {
                return match[3];
            }
        }
        return null;
    }
}
exports.JSXSimpleSelectorScanner = JSXSimpleSelectorScanner;
//# sourceMappingURL=jsx-scanner.js.map