part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzSubmissionStatus submissionStatus;
  final AcceptTerms acceptTerms;
  final String? errorMessage;
  final UserRole userRole;

  const LoginState({
    required this.email,
    required this.password,
    required this.submissionStatus,
    required this.confirmPassword,
    required this.acceptTerms,
    required this.userRole,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        submissionStatus,
        errorMessage,
        confirmPassword,
        acceptTerms,
        userRole,
      ];

  @override
  String toString() {
    return 'LoginState{acceptTerms: $acceptTerms}';
  }

  LoginState copyWith({
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzSubmissionStatus? submissionStatus,
    AcceptTerms? acceptTerms,
    String? errorMessage,
    UserRole? userRole,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      errorMessage: errorMessage ?? this.errorMessage,
      userRole: userRole ?? this.userRole,
    );
  }
}
