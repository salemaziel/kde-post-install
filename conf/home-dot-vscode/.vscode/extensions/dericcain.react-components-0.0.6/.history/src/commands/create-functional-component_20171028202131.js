const vscode = require('vscode');
const path = require('path');
const fs = require('fs');

class CreateFunctionalComponent {
  constructor() {
    this.getComponentName();
    this.createComponent();
  }  
 
  getComponentName() {
    vscode
      .window
      .showInputBox({prompt: 'Give your component a AHHHH...'})
      .then(fileName => this.fileName = fileName);
  }

  createComponent() {

  }
}

module.exports = new CreateFunctionalComponent();