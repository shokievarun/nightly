extension EmailValidation on String {
  bool isValidEmail() {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$');

    return emailRegex.hasMatch(this);
  }
}
