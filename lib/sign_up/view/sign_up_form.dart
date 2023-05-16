import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track_theme/track_theme.dart';
import 'package:track/widgets/widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final signUpForm = GlobalKey<FormState>();

  //text field controllers
  final _nameController = TextEditingController(text: "name");
  final _emailController = TextEditingController(text: "test@mail.com");
  final _passwordController = TextEditingController(text: "123456");
  final _confirmPasswordController = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: signUpForm,
      child: Column(
        children: [
          AppStyle.sizedBoxSpace,
          NameField(controller: _nameController),
          AppStyle.sizedBoxSpace,
          EmailField(controller: _emailController),
          AppStyle.sizedBoxSpace,
          PasswordField(controller: _passwordController),
          AppStyle.sizedBoxSpace,
          ConfirmPasswordField(
              controller: _confirmPasswordController, password: _passwordController),
          AppStyle.sizedBoxSpace,
          FilledButton(
            style: AppStyle.fullWidthButton,
            onPressed: () => signUp(),
            child: Text(l10n.signUp),
          ),
          OutlinedButton(
            style: AppStyle.fullWidthButton,
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  //action
  void signUp() {
    if (signUpForm.currentState!.validate()) {
    context.read<SignUpCubit>().signUp(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
    }
  }
}
