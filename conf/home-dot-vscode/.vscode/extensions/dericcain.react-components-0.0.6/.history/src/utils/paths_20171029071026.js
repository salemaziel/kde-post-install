const vscode = require('vscode');
const path = require('path');
const config = require('./config');

const ROOT_DIR = /<root>/;
const COMPONENT_DIR = /<component>/;
const PROJECT_ROOT = vscode.workspace.workspaceFolders[0].uri.path;

const determinePath = (isTestPath = false) => {
  let basePath;
  if (isTestPath) {
    if (config().has('testsRoot')) {
     basePath =  config().get('testsRoot');
    } else {
      basePath = '__tests__';
    }
  } else {
    if (config().has('componentsRoot')) {
      basePath =  config().get('componentsRoot');
     } else {
       basePath = 'src/components';
     }
  }

  switch (true) {
    case ROOT_DIR.test(basePath):
      const path = basePath.replace(ROOT_DIR, PROJECT_ROOT);
    return;
    case COMPONENT_DIR.test(basePath):
      
    return basePath.join(
        window.activeTextEditor.document.fileName

      )
    default:
      return basePath;
  }
}

module.exports.determinePath = determinePath;