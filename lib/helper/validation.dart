bool hasUppercase(String val) {
  return val.contains(new RegExp(r'[A-Z]'));
}

bool hasLowercase(String val) {
  return val.contains(new RegExp(r'[a-z]'));
}

bool hasNumeric(String val) {
  return val.contains(new RegExp(r'[0-9]'));
}

bool isAlphaNum(String val) => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(val);

bool isAlphaWhitespace(String val) => RegExp(r'^[a-zA-Z ]+$').hasMatch(val);
