const CreateClassComponent = require('./create-class-component');
const CreateFunctionalComponent = require('./create-functional-component');

module.exports.commands = {
  class: new CreateClassComponent(),
  functional: new CreateFunctionalComponent(),
}