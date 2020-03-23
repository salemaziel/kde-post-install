const { window } = require('vscode');
const path = require('path');
const fs = require('fs');
const { determinePath } = require('../utils/paths');
const { replaceAll } = require('../utils/stub');
const { TEMPLATE_DIR } = require('../utils/constants');

class CreateComponent {
  constructor(templateName) {
    this.template = path.join(TEMPLATE_DIR, templateName);
    this.getComponentName();
  }

  async getComponentName() {
    this.fileName = await window.showInputBox({ prompt: 'Give your component a name...' });
      // .then(fileName => {
        // this.fileName = fileName;
        this.outputInfo = determinePath(this.fileName);
        this.createComponent();
      // });
  }

  createComponent() {
    const content = fs.readFileSync(
      this.template,
      null,
      'utf8'
    );
    const newComponent = replaceAll(content, '$COMPONENT_NAME$', this.fileName);
    if (!fs.existsSync(this.outputInfo.dir)) {
      fs.mkdirSync(this.outputInfo.dir);
    }
    fs.writeFileSync(this.outputInfo.fullPath, newComponent, 'utf8');
  }
}

module.exports = CreateComponent;
