"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const resolver = require("npm-module-path");
const postcss = require("postcss");
const micromatch = require("micromatch");
const RESOLVE_PROGRESS_HACK_SLEEP_IN_MS = 10;
const context = {
    autoprefixer: undefined,
    channels: {
        output: undefined
    }
};
function activate(context) {
    const onCommand = vscode_1.commands.registerTextEditorCommand('autoprefixer.execute', (textEditor) => {
        var _a;
        if (vscode_1.window.activeTextEditor === undefined) {
            return;
        }
        const document = textEditor.document;
        const selection = textEditor.selection;
        const filepath = document.uri.fsPath;
        const workspaceFolderUri = (_a = vscode_1.workspace.getWorkspaceFolder(document.uri)) === null || _a === void 0 ? void 0 : _a.uri;
        const workspaceFolderFsPath = workspaceFolderUri === undefined ? filepath : workspaceFolderUri.fsPath;
        const settings = vscode_1.workspace.getConfiguration(undefined, workspaceFolderUri).get('autoprefixer');
        const block = getTextBlock(document, selection);
        if (settings.ignoreFiles.length !== 0) {
            if (micromatch([filepath], settings.ignoreFiles).length !== 0) {
                return;
            }
        }
        Promise.resolve()
            .then(async () => {
            await applyAutoprefixerToTextBlock(workspaceFolderFsPath, block, settings);
            if (block.warnings.length !== 0) {
                showOutput(`Warnings:\n${block.warnings.join('\n')}`);
            }
            if (!block.changed) {
                return;
            }
            await applyTextBlockToEditor(block, textEditor);
        })
            .catch((error) => {
            showOutput(error.stack === undefined ? error.message : error.stack);
        });
    });
    const onWillSave = vscode_1.workspace.onWillSaveTextDocument((event) => {
        var _a;
        const document = event.document;
        const filepath = document.uri.fsPath;
        const workspaceFolderUri = (_a = vscode_1.workspace.getWorkspaceFolder(document.uri)) === null || _a === void 0 ? void 0 : _a.uri;
        const workspaceFolderFsPath = workspaceFolderUri === undefined ? filepath : workspaceFolderUri.fsPath;
        const settings = vscode_1.workspace.getConfiguration(undefined, workspaceFolderUri).get('autoprefixer');
        if (!settings.formatOnSave) {
            return null;
        }
        const block = getTextBlock(document);
        if (settings.ignoreFiles.length !== 0) {
            if (micromatch([filepath], settings.ignoreFiles).length !== 0) {
                return null;
            }
        }
        const visibleTextEditors = vscode_1.window.visibleTextEditors;
        const currentEditor = visibleTextEditors.find((editor) => editor.document.fileName === document.fileName);
        const action = Promise.resolve()
            .then(async () => {
            await applyAutoprefixerToTextBlock(workspaceFolderFsPath, block, settings);
            if (block.warnings.length !== 0) {
                showOutput(`Warnings:\n${block.warnings.join('\n')}`);
            }
            if (!block.changed) {
                return;
            }
            if (currentEditor === undefined) {
                vscode_1.TextEdit.replace(block.range, block.content);
            }
            else {
                await applyTextBlockToEditor(block, currentEditor);
            }
        })
            .catch((error) => {
            showOutput(error.stack === undefined ? error.message : error.stack);
        });
        return event.waitUntil(action);
    });
    context.subscriptions.push(onCommand);
    context.subscriptions.push(onWillSave);
}
exports.activate = activate;
async function applyTextBlockToEditor(block, editor) {
    return editor.edit((builder) => {
        builder.replace(block.range, block.content);
    });
}
function showOutput(message) {
    if (context.channels.output === undefined) {
        context.channels.output = vscode_1.window.createOutputChannel('Autoprefixer');
    }
    context.channels.output.clear();
    context.channels.output.append(`[Autoprefixer]\n${message}`);
    context.channels.output.show();
}
function isSupportedLanguage(languageId) {
    return ['css', 'postcss', 'less', 'scss'].includes(languageId);
}
async function getPostcssOptions(languageId) {
    switch (languageId) {
        case 'less':
            return {
                syntax: await Promise.resolve().then(() => require('postcss-less'))
            };
        case 'scss':
            return {
                syntax: await Promise.resolve().then(() => require('postcss-scss'))
            };
        case 'css':
            return {
                parser: await Promise.resolve().then(() => require('postcss-safe-parser'))
            };
        default:
            return {};
    }
}
async function applyAutoprefixerToTextBlock(workspaceFolderFsPath, block, settings) {
    if (!isSupportedLanguage(block.languageId)) {
        showOutput('Cannot execute Autoprefixer because there is not supported languages. Supported: LESS, SCSS, PostCSS and CSS.');
        return;
    }
    const autoprefixer = await resolveAutoprefixerModuleWithProgress(workspaceFolderFsPath, settings);
    const autoprefixerOptions = settings.options;
    const postcssOptions = await getPostcssOptions(block.languageId);
    const result = postcss([autoprefixer(autoprefixerOptions)])
        .process(block.content, postcssOptions);
    block.content = result.css;
    for (const warning of result.warnings()) {
        block.warnings.push(`[${warning.line}:${warning.column}] ${warning.text}`);
    }
    block.changed = true;
}
function getTextBlock(document, selection) {
    let range;
    let content;
    if (selection === undefined || selection.isEmpty) {
        const lastLine = document.lineAt(document.lineCount - 1);
        const start = new vscode_1.Position(0, 0);
        const end = new vscode_1.Position(document.lineCount - 1, lastLine.text.length);
        range = new vscode_1.Range(start, end);
        content = document.getText();
    }
    else {
        range = new vscode_1.Range(selection.start, selection.end);
        content = document.getText(range);
    }
    return {
        range,
        content,
        languageId: document.languageId,
        warnings: [],
        changed: false
    };
}
async function resolveAutoprefixerModuleWithProgress(root, settings) {
    const autoprefixer = await vscode_1.window.withProgress({
        title: '[vscode-autoprefixer] resolve module',
        location: vscode_1.ProgressLocation.Window
    }, async () => {
        /**
         * Hack to display the progress because the progress is not displayed
         * for synchronous operation of the import (`require` after TS compilation).
         */
        await sleep(RESOLVE_PROGRESS_HACK_SLEEP_IN_MS);
        return resolveAutoprefixerModule(root, settings);
    });
    return autoprefixer;
}
async function resolveAutoprefixerModule(root, settings) {
    if (context.autoprefixer !== undefined) {
        return context.autoprefixer;
    }
    let autoprefixer;
    if (settings.findExternalAutoprefixer) {
        try {
            const modulePath = await resolver.resolveOne('autoprefixer', root);
            autoprefixer = await Promise.resolve().then(() => require(modulePath));
        }
        catch (_a) {
            throw new Error([
                'Failed to load autoprefixer library.',
                'Please install autoprefixer in your workspace folder using **npm install autoprefixer**',
                'or globally using **npm install -g autoprefixer** and then run command again.'
            ].join(' '));
        }
    }
    else {
        autoprefixer = await Promise.resolve().then(() => require('autoprefixer'));
    }
    context.autoprefixer = autoprefixer;
    return autoprefixer;
}
function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
}
