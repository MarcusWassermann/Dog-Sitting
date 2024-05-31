class Validators {
  static bool isPasswordValid(String password, String passwordRepeat) {
    return password.isNotEmpty && password == passwordRepeat;
  }
}
