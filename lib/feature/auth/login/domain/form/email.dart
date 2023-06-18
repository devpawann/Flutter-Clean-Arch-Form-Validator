import 'package:formz/formz.dart';

enum EmailValidationError {
  empty(message: "Please enter email"),
  invalid(message: "Invalid email address");

  final String message;

  const EmailValidationError({required this.message});
}

class Email extends FormzInput<String, EmailValidationError>
    with FormzInputErrorCacheMixin {
  Email.pure() : super.pure("");

  Email.dirty({required String value}) : super.dirty(value);

  final _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.trim().isEmpty) {
      return EmailValidationError.empty;
    }
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
