import 'package:formz/formz.dart';

class UserRole extends FormzInput<String?, String>
    with FormzInputErrorCacheMixin {
  UserRole.dirty({required String value}) : super.dirty(value);

  UserRole.pure({String? value}) : super.pure(value);

  @override
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please Select User Role";
    }
    return null;
  }
}
