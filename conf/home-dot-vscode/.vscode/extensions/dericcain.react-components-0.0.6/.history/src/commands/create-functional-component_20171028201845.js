const vscode = require('vscode');
const path = require('path');

class CreateFunctionalComponent {
  constructor() {
    this.getComponentName();
  }  
 
 async getComponentName() {
    this.fileName = await vscode.window.showInputBox({prompt: 'Give your component a name...'});
  }  
}

module.exports = CreateFunctionalComponent;