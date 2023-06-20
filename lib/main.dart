import 'package:clean_arch_form_validation/feature/auth/login/data/repository/login_repo_impl.dart';
import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:clean_arch_form_validation/feature/auth/login/presentation/screen/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Formz Example')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocProvider(
            create: (context) =>
                LoginCubit(loginRepository: LoginRepositoryImpl()),
            child: const SingleChildScrollView(
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
