bool isValidPhoneNumber(String input) {
  final RegExp phoneRegExp = RegExp(r'^\d{10}$');
  return phoneRegExp.hasMatch(input);
}
