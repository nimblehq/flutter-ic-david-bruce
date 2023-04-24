extension StringExt on String {
  bool validateEmail() {
    String emailRegex = '[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}'
        '\\@'
        '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}'
        '('
        '\\.'
        '[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}'
        ')+';
    return RegExp(emailRegex).hasMatch(this) && trim().isNotEmpty;
  }

  bool validatePassword() {
    return trim().isNotEmpty;
  }
}
