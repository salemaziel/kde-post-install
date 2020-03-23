const { window } = require('vscode');
const path = require('path');
const fs = require('fs');
const { determinePath } = require('../utils/paths');

class CreateFunctionalComponent {
  constructor() {
    // check the config and see where to create the
    this.getComponentName();
  }
  
  getComponentName() {
    window.showInputBox({ prompt: 'Give your component a name...' }).then(fileName => {
      this.fileName = fileName;
      this.savePath = determinePath(fileName)
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
          const newComponent = content.replace('$COMPONENT_NAME$', this.fileName);
          try {
            const location = this.savePath.replace(this.fileName, '');
            if (!fs.existsSync(location)) {
              fs.mkdirSync(location);
            }
            fs.writeFileSync(this.savePath, newComponent, 'utf8');
          } catch (e) {
            console.log(e);
          }
        }
      }
    );
  }
}

module.exports = CreateFunctionalComponent;
