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
      path.join(__dirname, `../templates/stub-functional-component.js`),
      'utf8',
      (err, data) => {
        if (err) {
          console.error(err);
        } else {
          const newComponent = data.replace('$COMPONENT_NAME$', this.fileName);
          try {
            fs.writeFileSync(
              `${__dirname}/src/tests/${this.fileName}.js`,
              newComponent,
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

module.exports = CreateFunctionalComponent;