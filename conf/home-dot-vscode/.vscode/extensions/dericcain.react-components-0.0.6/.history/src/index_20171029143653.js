const vscode = require('vscode');
const CreateFunctionalComponent = require('./commands/create-functional-component');
const CreateClassComponent = require('./commands/create-class-component');

function activate(context) {
    let createClassComponent = vscode.commands.registerCommand(
        'extension.react-components:create-class-component', 
        () => { new CreateClassComponent() }
    );
    context.subscriptions.push(createClassComponent);

    let createFunctionalComponent = vscode.commands.registerCommand(
        'extension.react-components:create-functional-component', 
        () => { new CreateFunctionalComponent() }
    );
    context.subscriptions.push(createFunctionalComponent);

}
exports.activate = activate;
