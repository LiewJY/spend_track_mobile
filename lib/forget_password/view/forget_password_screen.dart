import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/forget_password/forget_password.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});
  //for routing
  static Page<void> page() =>
      const MaterialPage<void>(child: ForgetPasswordScreen());

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // backgroundColor: Theme.of(context).colorScheme.background,
        // surfaceTintColor: Theme.of(context).colorScheme.background,
        title: Text(
          l10n.resetPassword,
          // style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppStyle.paddingHorizontal,
          child: BlocProvider(
            create: (context) =>
                ForgetPasswordCubit(context.read<AuthRepository>()),
            child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state.status == ForgetPasswordStatus.failure) {
                  AppSnackBar.authError(context, state.error);
                }
                if (state.status == ForgetPasswordStatus.success) {
                  AppSnackBar.success(context, l10n.resetPasswordEmailSent);
                }
              },
              child: Form(
                child: ForgetPasswordForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//? form move to another file?
class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final forgetPasswordForm = GlobalKey<FormState>();

  //textfield
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Form(
      key: forgetPasswordForm,
      child: Column(
        children: [
          AppStyle.sizedBoxSpace,
          EmailField(controller: _emailController),
          AppStyle.sizedBoxSpace,
          FilledButton(
            style: AppStyle.fullWidthButton,
            onPressed: () => sendResetEmail(),
            child: Text(l10n.resetPassword),
          ),
        ],
      ),
    );
  }

  sendResetEmail() {
    if (forgetPasswordForm.currentState!.validate()) {
      context
          .read<ForgetPasswordCubit>()
          .resetPassword(email: _emailController.text);
    }
  }
}
