const vscode = require('vscode');

const ROOT_DIR = /<root>/;
const COMPONENT_DIR = /<component>/;
const PROJECT_ROOT = vscode.workspace.workspaceFolders[0].uri.path;

const determinePath = path => {
  switch (true) {
    case ROOT_DIR.test(path):
      const 
    return;
    case COMPONENT_DIR.test(path):
      return;
    default:
      return path;
  }
}

module.exports.determinePath = determinePath;