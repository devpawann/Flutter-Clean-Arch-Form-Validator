abstract class LoginRepository {
  Future<void> performLogin({required String email, required String password});
}
