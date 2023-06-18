import 'dart:developer';

import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:clean_arch_form_validation/feature/auth/login/presentation/widget/confirm_password_form_field.dart';
import 'package:clean_arch_form_validation/feature/auth/login/presentation/widget/email_form_field.dart';
import 'package:clean_arch_form_validation/feature/auth/login/presentation/widget/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController()..addListener(_handleEmailChange);
    _passwordController = TextEditingController()
      ..addListener(_handlePasswordChange);
    _confirmPasswordController = TextEditingController()
      ..addListener(
        _handleConfirmPasswordChange,
      );
    super.initState();
  }

  void _handleEmailChange() {
    BlocProvider.of<LoginCubit>(context).emailChanged(
      email: _emailController.text,
    );
  }

  void _handlePasswordChange() {
    BlocProvider.of<LoginCubit>(context).passwordChanged(
      password: _passwordController.text,
    );
  }

  void _handleConfirmPasswordChange() {
    BlocProvider.of<LoginCubit>(context).confirmPasswordChange(
      confirmPassword: _confirmPasswordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
              ),
            );
          }
        },
        child: Column(
          children: [
            EmailFormField(
              emailController: _emailController,
            ),
            PasswordFormField(
              passwordController: _passwordController,
            ),
            ConfirmPasswordFormField(
              passwordController: _confirmPasswordController,
            ),
            const SizedBox(
              height: 24,
            ),
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (oldState, newState) {
                return oldState.submissionStatus != newState.submissionStatus;
              },
              builder: (context, state) {
                return state.submissionStatus ==
                        FormzSubmissionStatus.inProgress
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_key.currentState?.validate() ?? false) {
                            BlocProvider.of<LoginCubit>(context).onLogin();
                          } else {
                            log("Validation Failed");
                          }
                        },
                        child: const Text('Submit'),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
