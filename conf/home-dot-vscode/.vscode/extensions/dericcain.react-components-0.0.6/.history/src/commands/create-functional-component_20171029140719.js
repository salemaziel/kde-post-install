const CreateComponent require('./create-component');

const { window } = require('vscode');
const path = require('path');
const fs = require('fs');
const { determinePath } = require('../utils/paths');
const { replaceAll } = require('../utils/stub');

class CreateFunctionalComponent {
  constructor() {
    // check the config and see where to create the
    new CreateComponent('stub-functional-component.js');
    // this.getComponentName();
  }
  
  getComponentName() {
    window.showInputBox({ prompt: 'Give your component a name...' }).then(fileName => {
      this.fileName = fileName;
      this.outputInfo = determinePath(fileName);
      this.createComponent();
    });
  }

  createComponent() {
    fs.readFile(
      path.join(__dirname, `../templates/stub-functional-component.js`),
      'utf8',
      (err, content) => {
        if (err) {
          console.error(err);
        } else {
          const newComponent = replaceAll(content, '$COMPONENT_NAME$', this.fileName);
          try {
            if (!fs.existsSync(this.outputInfo.dir)) {
              fs.mkdirSync(this.outputInfo.dir);
            }
            fs.writeFileSync(this.outputInfo.fullPath, newComponent, 'utf8');
            return true;
          } catch (e) {
            console.log(e);
          }
        }
      }
    );
  }
}

module.exports = CreateFunctionalComponent;
