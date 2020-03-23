const vscode = require('vscode');
const path = require('path');

class CreateFunctionalComponent {
  constructor() {
    this.getComponentName();
  }  
 
 getComponentName() {
    vscode.window.showInputBox({prompt: 'Give your component a name...'})
    .then(fileName => this.fileName = fileName);
  }  
}

module.exports = CreateFunctionalComponent;