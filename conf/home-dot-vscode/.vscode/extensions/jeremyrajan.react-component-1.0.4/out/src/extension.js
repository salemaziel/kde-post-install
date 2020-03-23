'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require("vscode");
const prettier_1 = require("prettier");
const utils_1 = require("./utils");
const path = require('path');
const prettyConfig = {
    // Fit code within this line limit
    printWidth: 80,
    // Number of spaces it should use per tab
    tabWidth: 2,
    // If true, will use single instead of double quotes
    singleQuote: true,
    // Controls the printing of trailing commas wherever possible
    trailingComma: false,
    // Controls the printing of spaces inside array and objects
    bracketSpacing: true,
    // Which parser to use. Valid options are 'flow' and 'babylon'
    parser: 'babylon'
};
const getComponentName = (vscode) => {
    const editor = vscode.window.activeTextEditor;
    const fileName = editor.document.fileName;
    let componentName = 'MyComponent';
    if (!editor) {
        return; // No open text editor
    }
    if (fileName && !fileName.includes('Untitled')) {
        // if we have a file name then take that.
        componentName = fileName.split(path.sep).pop().split('.')[0];
    }
    return utils_1.capitalize(componentName);
};
const createComponentCode = (componentName) => {
    const boilerplate = `import React from 'react';

    class ${componentName} extends React.Component {
      constructor() {
        super();
        this.state = {
          someKey: 'someValue'
        };
      }

      render() {
        return (
          <p>{this.state.someKey}</p>
        );
      }

      componentDidMount() {
        this.setState({
          someKey: 'otherValue'
        });
      }
    }

    export default ${componentName};`;
    return prettier_1.format(boilerplate, prettyConfig); // make things pretty, because who doesnt like pretty.
};
// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    const createComponent = vscode.commands.registerCommand('extension.createComponent', () => {
        const componentName = getComponentName(vscode);
        const componentCode = createComponentCode(componentName);
        // writes the code
        const editor = vscode.window.activeTextEditor;
        const editorEdit = vscode.window.activeTextEditor;
        editorEdit.edit((editBuilder) => {
            editBuilder.delete(editor.selection);
        }).then(() => {
            editorEdit.edit((editBuilder) => {
                editBuilder.insert(editor.selection.start, componentCode);
            });
        });
    });
    context.subscriptions.push(createComponent);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() {
    console.log('React Component EXT deactivated.');
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map