// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');

const CreateClassComponent = () => {
  vscode.window.showInputBox({prompt: 'Give your component a name...'})
    .then(fileName => vscode.window.showInformationMessage('Your input was ' + fileName));
}