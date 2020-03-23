const vscode = require('vscode');
const path = require('path');
const fs = require('fs');

export default class CreateFunctionalComponent {
  
  
  constructor() {
    this.baseDirectory = `${__dirname}/../../src`;
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
