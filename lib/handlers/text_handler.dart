String removeTags(String string) {
  return string.replaceAll(RegExp('<[a-zA-Z\w\/]+>'), '');
}
