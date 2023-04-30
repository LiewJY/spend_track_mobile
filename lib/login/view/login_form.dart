import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track/uitls/constant.dart';
import 'package:track/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginForm = GlobalKey<FormState>();

  //text field controllers
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
          EmailField(controller: _emailController),
          Constant.sizedBoxSpace,
          PasswordField(controller: _passwordController),
          Constant.sizedBoxSpace,
          FilledButton(
            style: Constant.fullWidthButton,
            onPressed: () => login(),
            // onPressed: () {
            //   context.read<LoginCubit>().loginWithCredentials(
            //       email: _emailController.text,
            //       password: _passwordController.text);
            // },
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
    );
  }

  void login() {
    context.read<LoginCubit>().loginWithCredentials(
        email: _emailController.text, password: _passwordController.text);
  }
}