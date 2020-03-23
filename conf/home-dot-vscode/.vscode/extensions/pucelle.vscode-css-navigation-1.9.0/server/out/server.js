"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const vscode_languageserver_1 = require("vscode-languageserver");
const simple_selector_1 = require("./languages/common/simple-selector");
const html_1 = require("./languages/html");
const css_1 = require("./languages/css");
const libs_1 = require("./libs");
process.on('unhandledRejection', function (reason) {
    libs_1.timer.log("Unhandled Rejection: " + reason);
});
let connection = vscode_languageserver_1.createConnection(vscode_languageserver_1.ProposedFeatures.all);
let configuration;
let documents = new vscode_languageserver_1.TextDocuments();
let server;
libs_1.timer.pipeTo(connection);
connection.onInitialize((params) => {
    let options = params.initializationOptions;
    configuration = options.configuration;
    server = new CSSNaigationServer(options);
    return {
        capabilities: {
            textDocumentSync: {
                openClose: true,
                change: vscode_languageserver_1.TextDocumentSyncKind.Full
            },
            completionProvider: configuration.enableIdAndClassNameCompletion ? {
                resolveProvider: false
            } : undefined,
            definitionProvider: configuration.enableGoToDefinition,
            referencesProvider: configuration.enableFindAllReferences,
            workspaceSymbolProvider: configuration.enableWorkspaceSymbols
        }
    };
});
connection.onInitialized(() => {
    if (configuration.enableGoToDefinition) {
        connection.onDefinition(libs_1.timer.logListReturnedFunctionExecutedTime(server.findDefinitions.bind(server), 'definition'));
    }
    if (configuration.enableWorkspaceSymbols) {
        connection.onWorkspaceSymbol(libs_1.timer.logListReturnedFunctionExecutedTime(server.findSymbolsMatchQueryParam.bind(server), 'workspace symbol'));
    }
    if (configuration.enableIdAndClassNameCompletion) {
        connection.onCompletion(libs_1.timer.logListReturnedFunctionExecutedTime(server.provideCompletion.bind(server), 'completion'));
    }
    if (configuration.enableFindAllReferences) {
        connection.onReferences(libs_1.timer.logListReturnedFunctionExecutedTime(server.findRefenerces.bind(server), 'reference'));
    }
});
documents.listen(connection);
connection.listen();
class CSSNaigationServer {
    constructor(options) {
        this.htmlServiceMap = null;
        this.options = options;
        this.cssServiceMap = new css_1.CSSServiceMap({
            connection,
            documents,
            includeGlobPattern: libs_1.file.generateGlobPatternFromExtensions(configuration.activeCSSFileExtensions),
            excludeGlobPattern: libs_1.file.generateGlobPatternFromPatterns(configuration.excludeGlobPatterns),
            alwaysIncludeGlobPattern: libs_1.file.generateGlobPatternFromPatterns(configuration.alwaysIncludeGlobPatterns),
            updateImmediately: configuration.preloadCSSFiles,
            startPath: options.workspaceFolderPath,
            ignoreSameNameCSSFile: configuration.ignoreSameNameCSSFile && configuration.activeCSSFileExtensions.length > 1 && configuration.activeCSSFileExtensions.includes('css'),
            ignoreFilesBy: configuration.ignoreFilesBy,
        });
        //onDidChangeWatchedFiles can't been registered for twice, or the first one will not work, so handle it here, not on service map
        connection.onDidChangeWatchedFiles((params) => {
            this.cssServiceMap.onWatchedPathChanged(params);
            if (this.htmlServiceMap) {
                this.htmlServiceMap.onWatchedPathChanged(params);
            }
        });
        libs_1.timer.log(`Server for workspace folder "${path.basename(this.options.workspaceFolderPath)}" started`);
    }
    async findDefinitions(positonParams) {
        let documentIdentifier = positonParams.textDocument;
        let document = documents.get(documentIdentifier.uri);
        let position = positonParams.position;
        if (!document) {
            return null;
        }
        if (!configuration.activeHTMLFileExtensions.includes(libs_1.file.getExtension(document.uri))) {
            return null;
        }
        let selector = await html_1.HTMLService.getSimpleSelectorAt(document, position);
        if (!selector) {
            return null;
        }
        if (configuration.ignoreCustomElement && selector.type === simple_selector_1.SimpleSelector.Type.Tag && selector.value.includes('-')) {
            return null;
        }
        // If module css file not in current work space folder, create an `CSSService`.
        if (selector.filePath) {
            let cssService = await this.cssServiceMap.get(selector.filePath) || null;
            if (!cssService) {
                cssService = await css_1.CSSService.createFromFilePath(selector.filePath);
            }
            if (cssService) {
                return cssService.findDefinitionsMatchSelector(selector);
            }
            else {
                return null;
            }
        }
        let locations = await this.cssServiceMap.findDefinitionsMatchSelector(selector);
        if (configuration.alsoSearchDefinitionsInStyleTag) {
            locations.unshift(...html_1.HTMLService.findDefinitionsInInnerStyle(document, selector));
        }
        return locations;
    }
    async findSymbolsMatchQueryParam(symbol) {
        let query = symbol.query;
        if (!query) {
            return null;
        }
        //should have at least one word character
        if (!/[a-z]/i.test(query)) {
            return null;
        }
        return await this.cssServiceMap.findSymbolsMatchQuery(query);
    }
    async provideCompletion(params) {
        let documentIdentifier = params.textDocument;
        let document = documents.get(documentIdentifier.uri);
        let position = params.position;
        if (!document) {
            return null;
        }
        if (!configuration.activeHTMLFileExtensions.includes(libs_1.file.getExtension(document.uri))) {
            return null;
        }
        let selector = await html_1.HTMLService.getSimpleSelectorAt(document, position);
        if (!selector || selector.type === simple_selector_1.SimpleSelector.Type.Tag) {
            return null;
        }
        // If module css file not in current work space folder, create an `CSSService` to load it.
        if (selector.filePath) {
            let cssService = await this.cssServiceMap.get(selector.filePath) || null;
            if (!cssService) {
                cssService = await css_1.CSSService.createFromFilePath(selector.filePath);
            }
            if (cssService) {
                let labels = cssService.findCompletionLabelsMatchSelector(selector);
                return this.formatLabelsToCompletionItems(labels);
            }
            else {
                return null;
            }
        }
        let labels = await this.cssServiceMap.findCompletionLabelsMatchSelector(selector);
        return this.formatLabelsToCompletionItems(labels);
    }
    formatLabelsToCompletionItems(labels) {
        return labels.map(label => {
            let item = vscode_languageserver_1.CompletionItem.create(label);
            item.kind = vscode_languageserver_1.CompletionItemKind.Class;
            return item;
        });
    }
    async findRefenerces(params) {
        let documentIdentifier = params.textDocument;
        let document = documents.get(documentIdentifier.uri);
        let position = params.position;
        if (!document) {
            return null;
        }
        let extension = libs_1.file.getExtension(document.uri);
        if (configuration.activeHTMLFileExtensions.includes(extension)) {
            if (configuration.alsoSearchDefinitionsInStyleTag) {
                let filePath = vscode_languageserver_1.Files.uriToFilePath(document.uri);
                let htmlService = this.htmlServiceMap ? this.htmlServiceMap.get(filePath) : undefined;
                if (!htmlService) {
                    htmlService = html_1.HTMLService.create(document);
                }
                return html_1.HTMLService.findReferencesInInner(document, position, htmlService);
            }
            return null;
        }
        if (!configuration.activeCSSFileExtensions.includes(extension)) {
            return null;
        }
        let selectors = css_1.CSSService.getSimpleSelectorAt(document, position);
        let locations = [];
        this.ensureHTMLService();
        if (selectors) {
            for (let selector of selectors) {
                locations.push(...await this.htmlServiceMap.findReferencesMatchSelector(selector));
            }
        }
        return locations;
    }
    ensureHTMLService() {
        let { options } = this;
        this.htmlServiceMap = this.htmlServiceMap || new html_1.HTMLServiceMap({
            connection,
            documents,
            includeGlobPattern: libs_1.file.generateGlobPatternFromExtensions(configuration.activeHTMLFileExtensions),
            excludeGlobPattern: libs_1.file.generateGlobPatternFromPatterns(configuration.excludeGlobPatterns),
            updateImmediately: false,
            startPath: options.workspaceFolderPath
        });
    }
}
//# sourceMappingURL=server.js.map