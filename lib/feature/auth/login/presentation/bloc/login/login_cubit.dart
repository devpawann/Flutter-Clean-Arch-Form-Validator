import 'package:clean_arch_form_validation/feature/auth/login/domain/form/accept_terms.dart';
import 'package:clean_arch_form_validation/feature/auth/login/domain/form/form.dart';
import 'package:clean_arch_form_validation/feature/auth/login/domain/form/user_role.dart';
import 'package:clean_arch_form_validation/feature/auth/login/domain/repository/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginRepository,
  }) : super(
          LoginState(
            email: Email.pure(),
            password: Password.pure(),
            submissionStatus: FormzSubmissionStatus.initial,
            confirmPassword: ConfirmPassword.pure(),
            acceptTerms: AcceptTerms.pure(),
            userRole: UserRole.pure(),
          ),
        );

  final LoginRepository loginRepository;

  void emailChanged({required String email}) {
    emit(
      state.copyWith(
        email: Email.dirty(value: email),
        errorMessage: null,
      ),
    );
  }

  void passwordChanged({required String password}) {
    emit(
      state.copyWith(
        password: Password.dirty(value: password),
        confirmPassword: ConfirmPassword.dirty(
          password: password,
          value: state.confirmPassword.value,
        ),
        errorMessage: null,
      ),
    );
  }

  void confirmPasswordChange({required String confirmPassword}) {
    emit(
      state.copyWith(
        confirmPassword: ConfirmPassword.dirty(
          password: state.password.value,
          value: confirmPassword,
        ),
        errorMessage: null,
      ),
    );
  }

  void userRoleChange({required String userRole}) {
    emit(
      state.copyWith(
        userRole: UserRole.dirty(
          value: userRole,
        ),
        errorMessage: null,
      ),
    );
  }

  void acceptTermsChange({required bool acceptTerms}) {
    emit(
      state.copyWith(
        acceptTerms: AcceptTerms.dirty(
          value: acceptTerms,
        ),
        errorMessage: null,
      ),
    );
  }

  void onLogin() async {
    try {
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.inProgress,
          errorMessage: null,
        ),
      );
      await loginRepository.performLogin(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
          errorMessage: "Failed to login. Please try again.",
        ),
      );
    }
  }
}
