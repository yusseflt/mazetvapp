String removeTags(String string) {
  if (string == null) {
    return "There's no summary";
  }
  return string.replaceAll(RegExp('<[a-zA-Z\w\/]+>'), '');
}
