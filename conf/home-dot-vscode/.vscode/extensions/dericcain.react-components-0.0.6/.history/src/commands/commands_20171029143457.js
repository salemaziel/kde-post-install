const CreateComponent = require('./create-component');

module.exports.commands = {
  class: {
    action: new CreateComponent('stub-class-component.js'),
  },
  functional: {
    action: new CreateComponent('stub-functional-component.js'),
  },
}