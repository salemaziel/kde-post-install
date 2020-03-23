const vscode = require('vscode');
const CreateClassComponent = require('./src/commands/create-class-component');
const CreateFunctionalComponent = require('./src/commands/create-functional-component');

function activate(context) {
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
