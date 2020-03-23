"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const path = require("path");
const ignoreWalk = require('ignore-walk');
function readText(fsPath) {
    return new Promise((resolve, reject) => {
        fs.readFile(fsPath, 'utf8', (err, text) => {
            if (err) {
                reject(err);
            }
            else {
                resolve(text);
            }
        });
    });
}
exports.readText = readText;
function stat(fsPath) {
    return new Promise((resolve) => {
        fs.stat(fsPath, (err, stat) => {
            if (err) {
                resolve(null);
            }
            else {
                resolve(stat);
            }
        });
    });
}
exports.stat = stat;
function fileExists(fsPath) {
    return new Promise((resolve) => {
        fs.stat(fsPath, (err, stat) => {
            if (err) {
                resolve(false);
            }
            else {
                resolve(stat.isFile());
            }
        });
    });
}
exports.fileExists = fileExists;
function generateGlobPatternFromPatterns(patterns) {
    if (patterns.length > 1) {
        return '{' + patterns.join(',') + '}';
    }
    else if (patterns.length === 1) {
        return patterns[0];
    }
    return undefined;
}
exports.generateGlobPatternFromPatterns = generateGlobPatternFromPatterns;
function generateGlobPatternFromExtensions(extensions) {
    if (extensions.length > 1) {
        return '**/*.{' + extensions.join(',') + '}';
    }
    else if (extensions.length === 1) {
        return '**/*.' + extensions[0];
    }
    return undefined;
}
exports.generateGlobPatternFromExtensions = generateGlobPatternFromExtensions;
function getExtension(filePath) {
    return path.extname(filePath).slice(1).toLowerCase();
}
exports.getExtension = getExtension;
function replaceExtension(filePath, toExtension) {
    return filePath.replace(/\.\w+$/, '.' + toExtension);
}
exports.replaceExtension = replaceExtension;
// Will return the normalized full file path, only file paths, not include folder paths.
async function getFilePathsMathGlobPattern(folderPath, includeMatcher, excludeMatcher, ignoreFilesBy, alwaysIncludeGlobPattern) {
    let filePaths = await ignoreWalk({
        path: folderPath,
        ignoreFiles: ignoreFilesBy,
        includeEmpty: false,
        follow: false,
        alwaysIncludeGlobPattern,
    });
    let matchedFilePaths = new Set();
    for (let filePath of filePaths) {
        let absoluteFilePath = path.join(folderPath, filePath);
        if (includeMatcher.match(filePath) && (!excludeMatcher || !excludeMatcher.match(absoluteFilePath))) {
            matchedFilePaths.add(absoluteFilePath);
        }
    }
    return [...matchedFilePaths];
}
exports.getFilePathsMathGlobPattern = getFilePathsMathGlobPattern;
async function resolveImportPath(fromPath, toPath) {
    let isModulePath = toPath.startsWith('~');
    let fromDir = path.dirname(fromPath);
    let fromPathExtension = path.extname(fromPath).slice(1).toLowerCase();
    if (isModulePath) {
        while (fromDir) {
            let filePath = await resolvePath(path.resolve(fromDir, 'node_modules/' + toPath.slice(1)), fromPathExtension);
            if (filePath) {
                return filePath;
            }
            let dir = path.dirname(fromDir);
            if (dir === fromDir) {
                break;
            }
            fromDir = dir;
        }
        return null;
    }
    else {
        return await resolvePath(path.resolve(fromDir, toPath), fromPathExtension);
    }
}
exports.resolveImportPath = resolveImportPath;
async function resolvePath(filePath, fromPathExtension) {
    if (await fileExists(filePath)) {
        return filePath;
    }
    if (fromPathExtension === 'scss') {
        // @import `b` -> `b.scss`
        if (path.extname(filePath) === '') {
            filePath += '.scss';
            if (await fileExists(filePath)) {
                return filePath;
            }
        }
        // @import `b.scss` -> `_b.scss`
        if (path.basename(filePath)[0] !== '_') {
            filePath = path.join(path.dirname(filePath), '_' + path.basename(filePath));
            if (await fileExists(filePath)) {
                return filePath;
            }
        }
    }
    // One issue here:
    //   If we rename `b.scss` to `_b.scss` in `node_modules`,
    //   we can't get file changing notification from VSCode,
    //   and we can't reload it from path because nothing changes in it.
    // So we need to validate if import paths exist after we got definition results.
    // Although we still can't get results in `_b.scss`.
    // TODO
    return null;
}
//# sourceMappingURL=file.js.map