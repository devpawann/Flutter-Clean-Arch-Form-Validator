import 'dart:developer';

import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError {
  empty(message: "Please enter password"),
  notMatch(message: "Password and confirm password do not match");

  final String message;

  const ConfirmPasswordValidationError({required this.message});
}

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError>
    with FormzInputErrorCacheMixin {
  final String password;

  ConfirmPassword.pure([this.password = '']) : super.pure("");

  ConfirmPassword.dirty({required this.password, required String value})
      : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    log("==== $password $value");
    if (value.trim().isEmpty) {
      return ConfirmPasswordValidationError.empty;
    }
    if (password != value) {
      return ConfirmPasswordValidationError.notMatch;
    }
    return null;
  }
}
