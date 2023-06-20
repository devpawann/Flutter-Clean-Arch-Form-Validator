import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (oldState, newState) {
        return oldState.password != newState.password;
      },
      builder: (context, state) {
        // log("Password $state");
        return TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            errorText: state.password.displayError?.message,
            icon: const Icon(Icons.lock),
            helperText: 'At least 8 characters including one letter and number',
            helperMaxLines: 2,
            labelText: 'Password',
            errorMaxLines: 2,
          ),
          obscureText: true,
          textInputAction: TextInputAction.done,
          validator: (_) => state.password.error?.message,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        );
      },
    );
  }
}
