import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropDownFormField extends StatelessWidget {
  const CustomDropDownFormField({
    super.key,
    required List<DropdownMenuItem<String>> items,
  }) : _items = items;

  final List<DropdownMenuItem<String>> _items;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (oldState, newState) {
        return oldState.userRole != newState.userRole;
      },
      builder: (context, state) {
        return DropdownButtonFormField<String?>(
          items: _items,
          onChanged: (v) {
            BlocProvider.of<LoginCubit>(context).userRoleChange(userRole: v!);
          },
          hint: const Text("Please Select User Role"),
          isExpanded: true,
          value: state.userRole.value,
          validator: (_) => state.userRole.error,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            icon: const Icon(Icons.person),
            helperMaxLines: 2,
            errorText: state.userRole.displayError,
            labelText: 'User Role',
            errorMaxLines: 2,
          ),
        );
      },
    );
  }
}
