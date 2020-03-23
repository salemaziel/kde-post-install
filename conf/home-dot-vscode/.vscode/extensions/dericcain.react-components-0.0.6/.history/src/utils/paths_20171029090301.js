const { window, workspace } = require('vscode');
const path = require('path');
const config = require('./config');

const ROOT_DIR = /<root>/;
const COMPONENT_DIR = /<component>/;
const PROJECT_ROOT = workspace.workspaceFolders[0].uri.path;
const CURRENT_FILE_DIR = path.dirname(window.activeTextEditor.document.fileName);
const FILE_EXTENSTION = config().has('componentsFileExtension')
  ? config().get('componentsFileExtension')
  : '.js';

function basePath(isTestPath) {
  if (isTestPath) {
    if (config().has('testsRoot')) {
      return config().get('testsRoot');
    }
    return '__tests__';
  } else {
    if (config().has('componentsRoot')) {
      return config().get('componentsRoot');
    }
    return 'src/components';
  }
}

const determinePath = (fileName, isTestPath = false) => {
  const baseOutputPath = basePath(isTestPath);
  const outputFileName = fileName + FILE_EXTENSTION;

  switch (true) {
    case ROOT_DIR.test(baseOutputPath):
      const outputDir = baseOutputPath.replace(ROOT_DIR, PROJECT_ROOT);
      return {
        fullPath: path.join(outputDir, outputFileName),
        fileName: outputFileName,
        dir: outputDir,
      };
    case COMPONENT_DIR.test(baseOutputPath):
      const outputDir = path.join(baseOutputPath.replace(COMPONENT_DIR, CURRENT_FILE_DIR));
      return {
        fullPath: path.join(outputDir, outputFileName),
        fileName: outputFileName,
        dir: outputDir
      };
    default:
      return path.join(PROJECT_ROOT, baseOutputPath, outputFileName);
  }
};

module.exports.determinePath = determinePath;
