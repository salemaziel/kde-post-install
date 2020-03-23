"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_languageserver_1 = require("vscode-languageserver");
const html_range_parser_1 = require("./html-range-parser");
const html_scanner_1 = require("./html-scanner");
const jsx_scanner_1 = require("./jsx-scanner");
const css_service_1 = require("../css/css-service");
//it doesn't keep document
class HTMLService {
    constructor(document, ranges) {
        this.uri = document.uri;
        this.ranges = ranges;
    }
    findLocationsMatchSelector(selector) {
        let locations = [];
        for (let range of this.ranges) {
            if (range.name === selector.raw) {
                locations.push(vscode_languageserver_1.Location.create(this.uri, range.range));
            }
        }
        return locations;
    }
}
exports.HTMLService = HTMLService;
(function (HTMLService) {
    function create(document) {
        let ranges = new html_range_parser_1.HTMLRangeParser(document).parse();
        return new HTMLService(document, ranges);
    }
    HTMLService.create = create;
    async function getSimpleSelectorAt(document, position) {
        let offset = document.offsetAt(position);
        if (['javascriptreact', 'typescriptreact', 'javascript', 'typescript'].includes(document.languageId)) {
            let selector = await new jsx_scanner_1.JSXSimpleSelectorScanner(document, offset).scan();
            if (selector) {
                return selector;
            }
        }
        return await new html_scanner_1.HTMLSimpleSelectorScanner(document, offset).scan();
    }
    HTMLService.getSimpleSelectorAt = getSimpleSelectorAt;
    function findDefinitionsInInnerStyle(document, select) {
        let text = document.getText();
        let re = /<style\b(.*?)>(.*?)<\/style>|css`(.*?)`/gs;
        let match;
        let locations = [];
        while (match = re.exec(text)) {
            let languageId = match[1] ? getLanguageIdFromPropertiesText(match[1] || '') : 'css';
            let cssText = match[2] || match[3];
            let styleIndex = match[2]
                ? re.lastIndex - 8 - cssText.length // 8 is the length of `</style>`
                : re.lastIndex - 1 - cssText.length; // 1 is the length of `
            let cssDocument = vscode_languageserver_1.TextDocument.create('untitled.' + languageId, languageId, 0, cssText);
            let cssLocations = css_service_1.CSSService.create(cssDocument).findDefinitionsMatchSelector(select);
            for (let location of cssLocations) {
                let startIndexInCSS = cssDocument.offsetAt(location.range.start);
                let endIndexInCSS = cssDocument.offsetAt(location.range.end);
                let startIndexInHTML = startIndexInCSS + styleIndex;
                let endIndexInHTML = endIndexInCSS + styleIndex;
                locations.push(vscode_languageserver_1.Location.create(document.uri, vscode_languageserver_1.Range.create(document.positionAt(startIndexInHTML), document.positionAt(endIndexInHTML))));
            }
        }
        return locations;
    }
    HTMLService.findDefinitionsInInnerStyle = findDefinitionsInInnerStyle;
    function findReferencesInInner(document, position, htmlService) {
        let text = document.getText();
        let re = /<style\b(.*?)>(.*?)<\/style>/gs;
        let match;
        let locations = [];
        let offset = document.offsetAt(position);
        while (match = re.exec(text)) {
            let languageId = getLanguageIdFromPropertiesText(match[1] || '');
            let cssText = match[2];
            let styleStartIndex = re.lastIndex - 8 - cssText.length;
            let styleEndIndex = styleStartIndex + cssText.length;
            if (offset >= styleStartIndex && offset < styleEndIndex) {
                let cssDocument = vscode_languageserver_1.TextDocument.create('untitled.' + languageId, languageId, 0, cssText);
                let selectors = css_service_1.CSSService.getSimpleSelectorAt(cssDocument, cssDocument.positionAt(offset - styleStartIndex));
                if (selectors) {
                    for (let selector of selectors) {
                        locations.push(...htmlService.findLocationsMatchSelector(selector));
                    }
                }
            }
        }
        return locations;
    }
    HTMLService.findReferencesInInner = findReferencesInInner;
    function getLanguageIdFromPropertiesText(text) {
        let propertiesMatch = text.match(/\b(scss|less|css)\b/i);
        let languageId = propertiesMatch ? propertiesMatch[1].toLowerCase() : 'css';
        return languageId;
    }
})(HTMLService = exports.HTMLService || (exports.HTMLService = {}));
//# sourceMappingURL=html-service.js.map