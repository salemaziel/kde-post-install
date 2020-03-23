const vscode = require('vscode');
const CreateClassComponent = require('./commands/create-class-component');
const CreateFunctionalComponent = require('./commands/create-functional-component');

function activate(context) {
    let createClassComponent = vscode.commands.registerCommand(
        'extension.react-components:create-class-component', 
        CreateClassComponent
    );

    let createFunctionalComponent = vscode.commands.registerCommand(
        'extension.react-components:create-functional-component', 
        new CreateFunctionalComponent()
    );
    
    context.subscriptions.push(createClassComponent);
    context.subscriptions.push(createFunctionalComponent);
}
exports.activate = activate;
