import 'package:bloc/bloc.dart';
import 'package:clean_arch_form_validation/custom_form_types.dart';
import 'package:clean_arch_form_validation/repo/login_repo.dart';
import 'package:equatable/equatable.dart';
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
          ),
        );

  final LoginRepository loginRepository;

  void emailChanged({required String email}) {
    emit(
      state.copyWith(
        email: Email.dirty(value: email),
      ),
    );
  }

  void passwordChanged({required String password}) {
    emit(
      state.copyWith(
        password: Password.dirty(value: password),
      ),
    );
  }

  void onLogin() async {
    try {
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.inProgress,
        ),
      );
      await loginRepository.performLogin(
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
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
