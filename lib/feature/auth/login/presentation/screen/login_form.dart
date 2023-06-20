import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:clean_arch_form_validation/feature/auth/login/presentation/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final _items = ["User", "Admin"].map(
    (item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    },
  ).toList();

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
            const SizedBox(height: 24),
            CustomDropDownFormField(
              items: _items,
            ),
            const SizedBox(height: 24),
            const AcceptTermsCheckBox(),
            const SizedBox(height: 24),
            LoginButton(formKey: _key),
          ],
        ),
      ),
    );
  }
}
