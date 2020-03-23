function replaceAll(source, textToReplace, replaceWith) {
  return source.split(textToReplace).join(replaceWith);
}

module.exports.replaceAll = replaceAll;