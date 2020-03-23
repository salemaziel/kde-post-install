const CreateClassComponent = require('./create-class-component');
const CreateFunctionalComponent = require('./create-functional-component');

class CreateComponentFactory {
  constructor(type) {
    this.type = type;
    this.handle();
  }

  handle() {
    switch (this.type) {
      case 'class':
        return new CreateClassComponent();
      case 'functional':
        return new CreateFunctionalComponent();
    }
  }
}

module.exports = CreateComponentFactory;