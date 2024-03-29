import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/forget_password/forget_password.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track_theme/track_theme.dart';
import 'package:track/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginForm = GlobalKey<FormState>();

  //text field controllers
  //fixme remove setted value
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: loginForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmailField(
            controller: _emailController,
            textInputAction: 'next',
          ),
          AppStyle.sizedBoxSpace,
          PasswordField(controller: _passwordController),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                ),
                child: Text(l10n.forgetPassword),
              ),
            ],
          ),
          FilledButton(
            style: AppStyle.fullWidthButton,
            onPressed: () => login(),
            child: Text(l10n.login),
          ),
          OutlinedButton(
            style: AppStyle.fullWidthButton,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            ),
            child: Text(l10n.signUp),
          ),
        ],
      ),
    );
  }

  void login() {
    if (loginForm.currentState!.validate()) {
      context.read<LoginCubit>().loginWithCredentials(
          email: _emailController.text, password: _passwordController.text);
    }
  }
}
