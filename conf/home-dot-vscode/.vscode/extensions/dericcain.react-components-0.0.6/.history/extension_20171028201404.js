// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');
const CreateClassComponent = require('./src/commands/create-class-component');
const CreateFunctionalComponent = require('./src/commands/create-functional-component');

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    // The command has been defined in the package.json file
    // Now provide the implementation of the command with  registerCommand
    // The commandId parameter must match the command field in package.json
    let createClassComponent = vscode.commands.registerCommand(
        'extension.react-components:create-class-component', 
        CreateClassComponent
    );

    let createFunctionalComponent = vscode.commands.registerCommand(
        'extension.react-components:create-functional-component', 
        CreateFunctionalComponent
    );
    
    context.subscriptions.push(createClassComponent);
    context.subscriptions.push(createFunctionalComponent);
}
exports.activate = activate;
