const vscode = require('vscode');
const path = require('path');
const config = require('./config');

const ROOT_DIR = /<root>/;
const COMPONENT_DIR = /<component>/;
const PROJECT_ROOT = vscode.workspace.workspaceFolders[0].uri.path;
const CURRENT_FILE_DIR = path.dirname(window.activeTextEditor.document.fileName);

const determinePath = (fileName, isTestPath = false) => {
  let basePath;
  if (isTestPath) {
    if (config().has('testsRoot')) {
      basePath = config().get('testsRoot');
    } else {
      basePath = '__tests__';
    }
  } else {
    if (config().has('componentsRoot')) {
      basePath = config().get('componentsRoot');
    } else {
      basePath = 'src/components';
    }
  }

  switch (true) {
    case ROOT_DIR.test(basePath):
      return path.join(basePath.replace(ROOT_DIR, PROJECT_ROOT), fileName);
    case COMPONENT_DIR.test(basePath):
      return path.join(basePath.replace(COMPONENT_DIR, CURRENT_FILE_DIR), fileName);
    default:
      return path.join(basePath);
  }
};

module.exports.determinePath = determinePath;
