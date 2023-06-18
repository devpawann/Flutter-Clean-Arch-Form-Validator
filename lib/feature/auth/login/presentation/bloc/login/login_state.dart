part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  const LoginState({
    required this.email,
    required this.password,
    required this.submissionStatus,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        submissionStatus,
        errorMessage,
      ];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? submissionStatus,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'LoginState{email: $email, password: $password, submissionStatus: $submissionStatus, errorMessage: $errorMessage}';
  }
}
