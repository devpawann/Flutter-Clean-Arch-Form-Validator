import 'dart:developer';

import 'package:clean_arch_form_validation/bloc/login/login_cubit.dart';
import 'package:clean_arch_form_validation/repo/login_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Formz Example')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocProvider(
            create: (context) => LoginCubit(loginRepository: LoginRepository()),
            child: const SingleChildScrollView(child: MyForm()),
          ),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController()..addListener(_handleEmailChange);
    _passwordController = TextEditingController()
      ..addListener(_handlePasswordChange);
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (oldState, newState) {
              return oldState.email != newState.email;
            },
            builder: (context, state) {
              log("Email $state");
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
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (oldState, newState) {
              return oldState.password != newState.password;
            },
            builder: (context, state) {
              log("Password $state");
              return TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  helperText:
                      'At least 8 characters including one letter and number',
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
          ),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            buildWhen: (oldState, newState) {
              return oldState.submissionStatus != newState.submissionStatus;
            },
            builder: (context, state) {
              return state.submissionStatus == FormzSubmissionStatus.inProgress
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
    );
  }
}
