import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  //for routing
  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppStyle.paddingHorizontal,
          child: BlocProvider(
            create: (context) => LoginCubit(context.read<AuthRepository>()),
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.failure) {
                  AppSnackBar.authError(context, state.error);
                }
              },
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
