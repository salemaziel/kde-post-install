function replaceAll(source, textToReplace, replaceWith) {
  return source.split(textToReplace).join(replaceWith);
}
module.exports.replaceAll = replaceAll;

function replaceAllTest(source, testName, testPath) {
  const contentWithTestName = source.split('$COMPONENT_NAME$').join(testName);
  return contentWithTestName.split('$COMPONENT_PATH$').join(testPath);
}
module.exports.replaceAllTest = replaceAllTest;
