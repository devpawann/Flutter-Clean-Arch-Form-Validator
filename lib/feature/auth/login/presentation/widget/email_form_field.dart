import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (oldState, newState) {
        return oldState.email != newState.email;
      },
      builder: (context, state) {
        // log("Email $state");
        return TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            icon: const Icon(Icons.email),
            labelText: 'Email',
            helperText: 'A valid email e.g. joe.doe@gmail.com',
            errorText: state.email.displayError?.message,
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (_) => state.email.error?.message,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        );
      },
    );
  }
}
