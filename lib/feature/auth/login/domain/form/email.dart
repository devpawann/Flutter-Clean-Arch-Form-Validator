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
