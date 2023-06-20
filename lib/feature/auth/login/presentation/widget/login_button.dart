import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _key = formKey;

  final GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (oldState, newState) {
        return oldState.submissionStatus != newState.submissionStatus ||
            oldState.acceptTerms != newState.acceptTerms;
      },
      builder: (context, state) {
        return state.submissionStatus == FormzSubmissionStatus.inProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_key.currentState?.validate() ?? false) {
                    if (state.acceptTerms.value == false) {
                      BlocProvider.of<LoginCubit>(context).acceptTermsChange(
                        acceptTerms: state.acceptTerms.value,
                      );
                      return;
                    }
                    BlocProvider.of<LoginCubit>(context).onLogin();
                  }
                },
                child: const Text('Login'),
              );
      },
    );
  }
}
