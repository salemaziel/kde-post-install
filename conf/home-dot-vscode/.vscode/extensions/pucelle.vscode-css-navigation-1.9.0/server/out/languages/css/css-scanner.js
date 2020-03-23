"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const simple_selector_1 = require("../common/simple-selector");
const forward_scanner_1 = require("../common/forward-scanner");
const css_service_1 = require("./css-service");
const css_range_parser_1 = require("./css-range-parser");
class CSSSimpleSelectorScanner extends forward_scanner_1.ForwardScanner {
    constructor(document, offset) {
        super(document, offset);
        this.supportsNesting = css_service_1.CSSService.isLanguageSupportsNesting(document.languageId);
        this.startOffset = offset;
    }
    scan() {
        //when mouse in '|&-a', check if the next char is &
        let nextChar = this.peek(-1);
        if (nextChar === '#' || nextChar === '.' || this.supportsNesting && nextChar === '&') {
            this.back();
        }
        let word = this.readWholeWord();
        if (!word) {
            return null;
        }
        let char = this.read();
        if (char === '.' || char === '#') {
            let selector = simple_selector_1.SimpleSelector.create(char + word);
            return selector ? [selector] : null;
        }
        if (this.supportsNesting && char === '&') {
            return this.parseAndGetSelectors(word);
        }
        return null;
    }
    parseAndGetSelectors(word) {
        let { ranges } = new css_range_parser_1.CSSRangeParser(this.document).parse();
        let currentRange;
        let selectorIncludedParentRange;
        //binary searching should be a little better, but not help much
        for (let i = 0; i < ranges.length; i++) {
            let range = ranges[i];
            let start = this.document.offsetAt(range.range.start);
            let end = this.document.offsetAt(range.range.end);
            //is ancestor and has selector
            if (this.startOffset >= start && this.startOffset < end) {
                if (currentRange && this.isRangeHaveSelector(currentRange)) {
                    selectorIncludedParentRange = currentRange;
                }
                currentRange = range;
            }
            if (this.startOffset < start) {
                break;
            }
        }
        if (!selectorIncludedParentRange) {
            return null;
        }
        let selectors = [];
        for (let { full } of selectorIncludedParentRange.names) {
            if (full[0] === '.' || full[0] === '#') {
                let selector = simple_selector_1.SimpleSelector.create(full + word);
                if (selector) {
                    selectors.push(selector);
                }
            }
        }
        return selectors;
    }
    isRangeHaveSelector(range) {
        return range.names.some(({ mains }) => mains !== null);
    }
}
exports.CSSSimpleSelectorScanner = CSSSimpleSelectorScanner;
//# sourceMappingURL=css-scanner.js.map