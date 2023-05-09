import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track/utils/constant.dart';

import '../../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        surfaceTintColor: Theme.of(context).colorScheme.background,
        title: Text(
          l10n.signUp,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: Constant.paddingHorizontal,
        child: BlocProvider(
          create: (context) => SignUpCubit(context.read<AuthRepository>()),
          child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status == SignUpStatus.failure) {
                AppSnackBar.authError(context, state.error);
              }
              if (state.status == SignUpStatus.success) {
                Navigator.pop(context);
              }
            },
            child: SingleChildScrollView(child: SignUpForm()),
          ),
        ),
      )),
    );
  }
}
