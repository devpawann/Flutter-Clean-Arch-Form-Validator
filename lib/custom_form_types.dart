import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

enum PasswordValidationError { empty, short }

class Email extends FormzInput<String, EmailValidationError>
    with FormzInputErrorCacheMixin {
  Email.pure() : super.pure("");

  Email.dirty({required String value}) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return EmailValidationError.empty;
    } else if (value.trim().length < 5) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}

class Password extends FormzInput<String, PasswordValidationError>
    with FormzInputErrorCacheMixin {
  Password.pure() : super.pure("");

  Password.dirty({required String value}) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.trim().length < 5) {
      return PasswordValidationError.short;
    }
    return null;
  }
}
