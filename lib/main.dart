import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Formz Example')),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(child: MyForm()),
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
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: 'Email',
              helperText: 'A valid email e.g. joe.doe@gmail.com',
            ),
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          TextFormField(
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
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
