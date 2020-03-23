const path = require('path');
const { TEMPLATE_DIR } = require('../utils/constants');

const CreateClassComponent = require('./create-class-component');
const CreateFunctionalComponent = require('./create-functional-component');

module.exports.commands = {
  class: {
    action: new CreateClassComponent(),
    template: path.join(TEMPLATE_DIR, 'stub-class-component.js'),
  },
  functional: {
    action: new CreateFunctionalComponent(),
    template: path.join(TEMPLATE_DIR, 'stub-functional-component.js'),
  },
}