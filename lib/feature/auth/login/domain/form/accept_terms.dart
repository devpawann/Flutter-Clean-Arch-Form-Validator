import 'package:formz/formz.dart';

class AcceptTerms extends FormzInput<bool, String>
    with FormzInputErrorCacheMixin {
  AcceptTerms.dirty({required bool value}) : super.dirty(value);

  AcceptTerms.pure() : super.pure(false);

  @override
  String? validator(bool value) {
    if (!value) {
      return "Please accept terms";
    }
    return null;
  }
}
