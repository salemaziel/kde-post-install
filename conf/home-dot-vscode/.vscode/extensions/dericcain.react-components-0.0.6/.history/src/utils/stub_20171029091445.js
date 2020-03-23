function replaceAll(textToReplace, replaceWith) {
  return this.split(textToReplace).join(replaceWith);
}

module.exports.replaceAll = replaceAll;