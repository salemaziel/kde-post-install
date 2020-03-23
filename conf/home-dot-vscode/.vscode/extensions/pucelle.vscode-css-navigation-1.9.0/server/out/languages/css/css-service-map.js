"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const libs_1 = require("../../libs");
const css_service_1 = require("./css-service");
class CSSServiceMap extends libs_1.FileTracker {
    constructor(options) {
        super(options);
        this.serviceMap = new Map();
        this.ignoreSameNameCSSFile = options.ignoreSameNameCSSFile;
    }
    async get(filePath) {
        await this.beFresh();
        return this.serviceMap.get(filePath);
    }
    onTrack(filePath) {
        if (this.ignoreSameNameCSSFile) {
            let ext = path.extname(filePath).slice(1).toLowerCase();
            if (ext === 'css') {
                let sassOrLessExist = this.has(libs_1.file.replaceExtension(filePath, 'scss')) || this.has(libs_1.file.replaceExtension(filePath, 'scss'));
                if (sassOrLessExist) {
                    this.ignore(filePath);
                }
            }
            else {
                let cssPath = libs_1.file.replaceExtension(filePath, 'css');
                if (this.has(cssPath)) {
                    this.ignore(cssPath);
                }
            }
        }
    }
    onExpired(filePath) {
        this.serviceMap.delete(filePath);
    }
    onUnTrack(filePath) {
        this.serviceMap.delete(filePath);
        if (this.ignoreSameNameCSSFile) {
            let ext = path.extname(filePath).slice(1).toLowerCase();
            if (ext !== 'css') {
                let cssPath = libs_1.file.replaceExtension(filePath, 'css');
                if (this.has(cssPath)) {
                    this.notIgnore(cssPath);
                }
            }
        }
    }
    async onUpdate(filePath, item) {
        if (item.document) {
            let cssService = css_service_1.CSSService.create(item.document);
            this.serviceMap.set(filePath, cssService);
            let importPaths = await cssService.getResolvedImportPaths();
            if (importPaths.length > 0) {
                for (let importPath of importPaths) {
                    await this.trackAndUpdateImmediately(importPath);
                }
            }
            //very important, release document memory usage after symbols generated
            item.document = null;
        }
    }
    *iterateAvailableCSSServices() {
        for (let [filePath, cssService] of this.serviceMap.entries()) {
            if (!this.hasIgnored(filePath)) {
                yield cssService;
            }
        }
    }
    async findDefinitionsMatchSelector(selector) {
        await this.beFresh();
        let locations = [];
        for (let cssService of this.iterateAvailableCSSServices()) {
            locations.push(...cssService.findDefinitionsMatchSelector(selector));
        }
        return locations;
    }
    async findSymbolsMatchQuery(query) {
        await this.beFresh();
        let symbols = [];
        for (let cssService of this.iterateAvailableCSSServices()) {
            symbols.push(...cssService.findSymbolsMatchQuery(query));
        }
        return symbols;
    }
    async findCompletionLabelsMatchSelector(selector) {
        await this.beFresh();
        let labelSet = new Set();
        for (let cssService of this.iterateAvailableCSSServices()) {
            for (let label of cssService.findCompletionLabelsMatchSelector(selector)) {
                labelSet.add(label);
            }
        }
        return [...labelSet.values()];
    }
}
exports.CSSServiceMap = CSSServiceMap;
//# sourceMappingURL=css-service-map.js.map