const vscode = require('vscode');
const CreateComponentFactory = require('./commands/create-component-factory')

function activate(context) {
    let createClassComponent = vscode.commands.registerCommand(
        'extension.react-components:create-class-component', 
        new CreateComponentFactory('class')
    );

    let createFunctionalComponent = vscode.commands.registerCommand(
        'extension.react-components:create-functional-component', 
        new CreateComponentFactory('functional')
    );
    
    context.subscriptions.push(createClassComponent);
    context.subscriptions.push(createFunctionalComponent);
}
exports.activate = activate;
