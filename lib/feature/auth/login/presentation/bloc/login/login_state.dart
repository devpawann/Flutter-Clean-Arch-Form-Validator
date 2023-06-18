part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  const LoginState({
    required this.email,
    required this.password,
    required this.submissionStatus,
    required this.confirmPassword,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        submissionStatus,
        errorMessage,
        confirmPassword,
      ];

  @override
  String toString() {
    return 'LoginState{email: $email, password: $password, submissionStatus: $submissionStatus, errorMessage: $errorMessage}';
  }

  LoginState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? submissionStatus,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
