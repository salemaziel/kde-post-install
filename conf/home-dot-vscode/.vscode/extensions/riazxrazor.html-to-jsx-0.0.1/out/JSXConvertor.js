'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const HTMLtoJSX = require('htmltojsx');
class JSXConvertor {
    convert(input) {
        let output;
        let converter = new HTMLtoJSX({
            createClass: false,
        });
        output = converter.convert(input);
        return output;
    }
}
exports.default = JSXConvertor;
//# sourceMappingURL=JSXConvertor.js.map