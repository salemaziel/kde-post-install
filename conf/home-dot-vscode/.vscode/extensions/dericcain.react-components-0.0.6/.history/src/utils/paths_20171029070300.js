const vscode = require('vscode');
const path = require('path');
const config = require('./config');

const ROOT_DIR = /<root>/;
const COMPONENT_DIR = /<component>/;
const PROJECT_ROOT = vscode.workspace.workspaceFolders[0].uri.path;

const determinePath = (isTestPath = false) => {
  if (isTestPath) {
    
  }

  switch (true) {
    case ROOT_DIR.test(path):
      const 
    return;
    case COMPONENT_DIR.test(path):
      
    return path.join(
        window.activeTextEditor.document.fileName

      )
    default:
      return path;
  }
}

module.exports.determinePath = determinePath;