const CreateClassComponent = require('./create-class-component');
const CreateFunctionalComponent = require('./create-functional-component');

module.exports.commands = {
  class: {
    action: new CreateClassComponent(),
    template: 
  },
  functional: new CreateFunctionalComponent(),
}