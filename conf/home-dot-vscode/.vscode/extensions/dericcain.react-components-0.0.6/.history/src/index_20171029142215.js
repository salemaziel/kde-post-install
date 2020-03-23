const { commands } = require('vscode');
const CreateComponentFactory = require('./factories/create-component-factory');

function activate(context) {
    let createClassComponent = commands.registerCommand(
        'extension.react-components:create-class-component', 
        new CreateComponentFactory('class')
    );
    context.subscriptions.push(createClassComponent);

    let createFunctionalComponent = commands.registerCommand(
        'extension.react-components:create-functional-component', 
        new CreateComponentFactory('functional')
    );
    context.subscriptions.push(createFunctionalComponent);

}
exports.activate = activate;
