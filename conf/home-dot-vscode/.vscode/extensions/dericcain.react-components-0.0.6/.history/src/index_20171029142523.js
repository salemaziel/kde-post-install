const vscode = require('vscode');
const CreateComponentFactory = require('./factories/create-component-factory');
const commands = require('./commands/commands');

function activate(context) {
    let createClassComponent = vscode.commands.registerCommand(
        'extension.react-components:create-class-component', 
        commands.commands.class.action
        // () => { new CreateComponentFactory('class') }
    );
    context.subscriptions.push(createClassComponent);

    let createFunctionalComponent = vscode.commands.registerCommand(
        'extension.react-components:create-functional-component', 
        commands.commands.functional.action
        // () => { new CreateComponentFactory('functional') }
    );
    context.subscriptions.push(createFunctionalComponent);

}
exports.activate = activate;
