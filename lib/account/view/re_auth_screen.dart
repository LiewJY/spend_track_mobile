import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track/utils/constant.dart';
import 'package:track/widgets/widgets.dart';

class  ReAuthScreen extends StatefulWidget {
  const ReAuthScreen({super.key});

  @override
  State<ReAuthScreen> createState() => _ReAuthScreenState();
}

class _ReAuthScreenState extends State<ReAuthScreen> {
  final reAuthScreenForm = GlobalKey<FormState>();

  //text field controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Padding(
        padding: Constant.paddingHorizontal,
        child: SafeArea(
          child: Form(
            key: reAuthScreenForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailField(
                  controller: _emailController,
                  textInputAction: 'next',
                ),
                Constant.sizedBoxSpace,
                PasswordField(controller: _passwordController),
                Constant.sizedBoxSpace,
                FilledButton(
                  style: Constant.fullWidthButton,
                  onPressed: () => login(),
                  child: Text(l10n.login),
                ),
                OutlinedButton(
                  style: Constant.fullWidthButton,
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  ),
                  child: Text(l10n.signUp),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (reAuthScreenForm.currentState!.validate()) {
      context.read<LoginCubit>().loginWithCredentials(
          email: _emailController.text, password: _passwordController.text);
    }
  }
}
