import 'dart:developer' as dev;
import 'dart:math';

class LoginRepository {
  performLogin({required String email, required String password}) async {
    dev.log("Login on Progress Email: $email Password: $password");

    /// mimic delay
    await Future<void>.delayed(const Duration(seconds: 1));

    /// mimic failures
    if (Random().nextInt(2) == 0) throw Exception();
  }
}
