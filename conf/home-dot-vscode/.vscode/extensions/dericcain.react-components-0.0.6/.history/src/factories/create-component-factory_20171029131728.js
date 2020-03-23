const { commands } = require('../commands/commands');

class CreateComponentFactory {
  constructor(type) {
    this.type = type;
    this.handle();
  }

  handle() {
    return commands[this.type];
  }
}

module.exports = CreateComponentFactory;