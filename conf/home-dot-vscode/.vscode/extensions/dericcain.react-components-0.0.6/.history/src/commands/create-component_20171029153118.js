const { window, workspace } = require('vscode');
const path = require('path');
const fs = require('fs');
const config = require('../utils/config');
const { determinePath } = require('../utils/paths');
const { replaceAll } = require('../utils/stub');
const { TEMPLATE_DIR } = require('../utils/constants');

class CreateComponent {
  constructor(templateName) {
    this.template = path.join(TEMPLATE_DIR, templateName);
    this.getComponentName();
  }

  getComponentName() {
    window.showInputBox({ prompt: 'Give your component a name...' }).then(fileName => {
      this.fileName = fileName;
      this.outputInfo = determinePath(fileName);
      this.createComponent();
    });
  }

  createComponent() {
    fs.readFile(this.template, 'utf8', (error, content) => {
      if (error) throw new Error(error);
      if (/\//.test(this.fileName)) {
        const pathSections = this.fileName.split('/');
        this.fileName = pathSections[pathSections.length - 1];
      }   
      const newComponent = replaceAll(content, '$COMPONENT_NAME$', this.fileName);
      if (!fs.existsSync(this.outputInfo.dir)) {
        fs.mkdirSync(this.outputInfo.dir);
      }
      fs.writeFileSync(this.outputInfo.fullPath, newComponent, 'utf8');
      this.openFileIfNeeded();
    });
  }

  openFileIfNeeded() {
    if (config().has('openAfterCreate') && config().get('openAfterCreate')) {
      const file = workspace.openTextDocument(this.outputInfo.fullPath);
      window.showTextDocument(file);
    }
  }
}

module.exports = CreateComponent;
