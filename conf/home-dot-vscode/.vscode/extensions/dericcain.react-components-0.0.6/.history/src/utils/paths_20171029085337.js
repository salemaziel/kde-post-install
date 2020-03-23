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

function determinePath(fileName, isTestPath = false) {
  const basePath = basePath(isTestPath);
  const outputFileName = fileName + FILE_EXTENSTION;
 

  switch (true) {
    case ROOT_DIR.test(basePath):
      return path.join(basePath.replace(ROOT_DIR, PROJECT_ROOT), outputFileName);
    case COMPONENT_DIR.test(basePath):
      return path.join(basePath.replace(COMPONENT_DIR, CURRENT_FILE_DIR), outputFileName);
    default:
      return path.join(PROJECT_ROOT, basePath, outputFileName);
  }
};

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

module.exports.determinePath = determinePath;
