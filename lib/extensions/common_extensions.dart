extension EmailValidation on String {
  bool isValidEmail() {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');

    return emailRegex.hasMatch(this);
  }
}

extension NumericValidation on String {
  bool get isNumericOnly {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(this);
  }
}
