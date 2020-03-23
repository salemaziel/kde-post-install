"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var SimpleSelector;
(function (SimpleSelector) {
    let Type;
    (function (Type) {
        Type[Type["Tag"] = 0] = "Tag";
        Type[Type["Class"] = 1] = "Class";
        Type[Type["Id"] = 2] = "Id";
    })(Type = SimpleSelector.Type || (SimpleSelector.Type = {}));
    function create(raw, filePath = null) {
        if (!validate(raw)) {
            return null;
        }
        let type = raw[0] === '.' ? Type.Class
            : raw[0] === '#' ? Type.Id
                : Type.Tag;
        let value = type === Type.Tag ? raw : raw.slice(1);
        return {
            type,
            value,
            raw,
            filePath
        };
    }
    SimpleSelector.create = create;
    function validate(raw) {
        return /^[#.]?\w[\w-]*$/i.test(raw);
    }
    SimpleSelector.validate = validate;
})(SimpleSelector = exports.SimpleSelector || (exports.SimpleSelector = {}));
//# sourceMappingURL=simple-selector.js.map