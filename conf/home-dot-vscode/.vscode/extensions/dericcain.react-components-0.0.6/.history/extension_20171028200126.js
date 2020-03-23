// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');
const CreateClassComponent = require('./src/commands/create-class-component');

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    let createClassComponent = vscode.commands.registerCommand('extension.react-components:create-class-component', CreateClassComponent);
    
    let disposable = vscode.commands.registerCommand('extension.react-components', function () {
        // The code you place here will be executed every time your command is executed

        
    });

    context.subscriptions.push(disposable);
    context.subscriptions.push(createClassComponent);
}
exports.activate = activate;

// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;