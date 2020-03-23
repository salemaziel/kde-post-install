const vscode = require('vscode');

const CreateFunctionalComponent = () => {
  vscode.window.showInputBox({prompt: 'Give your component a name...'})
    .then(fileName => vscode.window.showInformationMessage('Your input was ' + fileName));
}

module.exports = CreateFunctionalComponent;