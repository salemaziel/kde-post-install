const vscode = require('vscode');

function config() {
  return vscode.workspace.getConfiguration('react-components');
}

module.exports = config();