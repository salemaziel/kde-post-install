const vscode = require('vscode');
const CreateClassComponent = require('./commands/create-class-component');
// const CreateFunctionalComponent = require('./commands/create-functional-component');
// const commands = require('./commands/commands');
const CreateComponentFactory = require('./factories/create-component-factory');

function activate(context) {
    let createClassComponent = vscode.commands.registerCommand(
        'extension.react-components:create-class-component', 
        CreateClassComponent
    );

    let createFunctionalComponent = vscode.commands.registerCommand(
        'extension.react-components:create-functional-component', 
        // new CreateFunctionalComponent()
        // commands.commands.functional.action
        new CreateComponentFactory('functional')
    );
    
    context.subscriptions.push(createClassComponent);
    context.subscriptions.push(createFunctionalComponent);
}
exports.activate = activate;
