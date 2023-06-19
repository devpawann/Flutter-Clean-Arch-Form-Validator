import 'dart:developer';

import 'package:clean_arch_form_validation/feature/auth/login/presentation/bloc/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptTermsCheckBox extends StatelessWidget {
  const AcceptTermsCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (old, newState) {
        return old.acceptTerms != newState.acceptTerms;
      },
      builder: (context, state) {
        log("CHECK $state ${state.acceptTerms.isPure}");
        return CheckboxListTile(
          tileColor: (state.acceptTerms.displayError == null)
              ? Colors.white
              : Colors.red.withOpacity(0.3),
          title: const Text("Accept Terms"),
          subtitle: Text(state.acceptTerms.displayError ?? ""),
          isError: (state.acceptTerms.displayError != null),
          value: state.acceptTerms.value,
          onChanged: (v) {
            BlocProvider.of<LoginCubit>(context).acceptTermsChange(
              acceptTerms: v ?? false,
            );
          },
        );
      },
    );
  }
}
