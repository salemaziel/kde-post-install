const vscode = require('vscode');
const path = require('path');
const fs = require('fs');

class CreateFunctionalComponent {
  constructor() {
    this.getComponentName();
    this.createComponent();
  }  
 
  getComponentName() {
    vscode
      .window
      .showInputBox({prompt: 'Give your component a name...'})
      .then(fileName => this.fileName = fileName);
  }

  createComponent() {
    fs.readFile(
      path.join(__dirname, `../templates/stub-controller.js`,
      'utf8',
      (err, data) => {
        if (err) {
          console.error(err);
        } else {
          const newController = data.replace('$NAME$', this.name);
          try {
            fs.writeFileSync(
              `${__dirname}/src/controllers/${this.name}.js`,
              newController,
              'utf8'
            );
          } catch (e) {
            console.log(e);
          }
        }
      }
    );
  }
}

module.exports = new CreateFunctionalComponent;