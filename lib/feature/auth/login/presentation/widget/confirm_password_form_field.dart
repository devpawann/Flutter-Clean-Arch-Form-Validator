import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordFormField extends StatelessWidget {
  const ConfirmPasswordFormField({
    super.key,
    required TextEditingController passwordController,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (oldState, newState) {
        return ((oldState.confirmPassword != newState.confirmPassword) ||
            (oldState.password != newState.password));
      },
      builder: (context, state) {
        // log("Confirm Password $state");
        return TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            helperText: 'Enter password Again',
            helperMaxLines: 2,
            labelText: 'Confirm Password',
            errorMaxLines: 2,
          ),
          obscureText: true,
          textInputAction: TextInputAction.done,
          validator: (_) => state.confirmPassword.error?.message,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        );
      },
    );
  }
}
