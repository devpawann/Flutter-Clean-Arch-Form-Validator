import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty(message: "Please enter password"),
  short(message: "Enter strong password");

  final String message;

  const PasswordValidationError({required this.message});
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
