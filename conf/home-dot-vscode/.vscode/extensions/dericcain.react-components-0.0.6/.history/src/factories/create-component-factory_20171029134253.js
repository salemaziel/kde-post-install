const { commands } = require('../commands/commands');

class CreateComponentFactory {
  constructor(type) {
    this.handle(type);
  }

  handle(type) {
    return commands[type].action;
  }
}

module.exports = CreateComponentFactory;