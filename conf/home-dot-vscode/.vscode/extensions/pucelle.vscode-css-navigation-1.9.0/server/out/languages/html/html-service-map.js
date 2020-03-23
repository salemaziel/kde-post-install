"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const html_service_1 = require("./html-service");
const libs_1 = require("../../libs");
class HTMLServiceMap extends libs_1.FileTracker {
    constructor() {
        super(...arguments);
        this.serviceMap = new Map();
    }
    onTrack() { }
    onExpired(filePath) {
        this.serviceMap.delete(filePath);
    }
    onUnTrack(filePath) {
        this.serviceMap.delete(filePath);
    }
    async onUpdate(filePath, item) {
        if (item.document) {
            this.serviceMap.set(filePath, html_service_1.HTMLService.create(item.document));
            //very important, release document memory usage after symbols generated
            item.document = null;
        }
    }
    get(filePath) {
        return this.serviceMap.get(filePath);
    }
    async findReferencesMatchSelector(selector) {
        await this.beFresh();
        let locations = [];
        for (let htmlService of this.serviceMap.values()) {
            locations.push(...htmlService.findLocationsMatchSelector(selector));
        }
        return locations;
    }
}
exports.HTMLServiceMap = HTMLServiceMap;
//# sourceMappingURL=html-service-map.js.map