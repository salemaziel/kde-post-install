'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
class TextConversor {
    scapeAndSplitInput(input) {
        return input.replace(/'/g, "\\'").split("\n");
    }
}
exports.default = TextConversor;
//# sourceMappingURL=TextConversor.js.map