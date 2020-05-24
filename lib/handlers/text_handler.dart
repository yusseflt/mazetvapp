String removeTags(String string) {
  if (string == null) {
    return "Not available";
  }
  return string.replaceAll(RegExp('<[a-zA-Z\w\/]+>'), '');
}

String convertDate(date) {
  if (date is String) {
    date = DateTime.tryParse(date);
  }

  if (date == null) {
    return "Not available";
  }
  return '${date.day}/${date.month}/${date.year}';
}
