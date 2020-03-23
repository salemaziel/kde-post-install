const { window, workspace } = require('vscode');
const path = require('path');
const config = require('./config');

const ROOT_DIR_USER_VARIABLE = /<root>/;
const COMPONENT_DIR_USER_VARIABLE = /<component>/;
const PROJECT_ROOT = workspace.rootPath || workspace.workspaceFolders[0].uri.path;
const CURRENT_FILE_DIR = window.activeTextEditor 
  ? path.dirname(window.activeTextEditor.document.fileName)
  : workspace.rootPath;

const FILE_EXTENSION = config().has('fileExtension')
  ? config().get('fileExtension')
  : '.js';

const determinePath = (fileName, isTestPath = false) => {
  // We have this in case the user wants to enter a directory as the name of the component like so:
  // components/common/button.js
  const originalFileName = fileName;
  let additionalDir = '';
  if (/\//.test(fileName)) {
    const pathSections = originalFileName.split('/');
    fileName = pathSections[pathSections.length - 1];
    additionalDir = pathSections.slice(0, pathSections.length - 1).join('/');
  }
  const baseOutputPath = basePath(isTestPath);
  let outputFileName;
  if (isTestPath) {
    outputFileName = config().has('testsAppendName')
      ? `${fileName}${config().get('testsAppendName')}${FILE_EXTENSION}`
      : fileName + FILE_EXTENSION;
  } else {
    outputFileName = fileName + FILE_EXTENSION;
  }

  switch (true) {
    case ROOT_DIR_USER_VARIABLE.test(baseOutputPath):
      const rootOutputDir = path.join(baseOutputPath.replace(ROOT_DIR_USER_VARIABLE, PROJECT_ROOT), additionalDir);
      return {
        fullPath: path.join(rootOutputDir, outputFileName),
        fileName: outputFileName,
        dir: rootOutputDir,
      };
    case COMPONENT_DIR_USER_VARIABLE.test(baseOutputPath):
      const componentOutputDir = path.join(baseOutputPath.replace(COMPONENT_DIR_USER_VARIABLE, CURRENT_FILE_DIR), additionalDir);
      return {
        fullPath: path.join(componentOutputDir, outputFileName),
        fileName: outputFileName,
        dir: componentOutputDir,
      };
    default:
      const defaultOutputDir = path.join(PROJECT_ROOT, baseOutputPath, additionalDir);
      return {
        fullPath: path.join(defaultOutputDir, outputFileName),
        fileName: outputFileName,
        dir: defaultOutputDir,
      };
  }
};

module.exports.determinePath = determinePath;

function basePath(isTestPath) {
  if (isTestPath) {
    return config().has('testsRoot') 
      ? config().get('testsRoot')
      : '__tests__';
  } else {
    return config().has('root')
      ? config().get('root')
      : 'src/components';
  }
}
