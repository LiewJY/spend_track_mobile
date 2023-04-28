import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track/widgets/widgets.dart';
import '../../uitls/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //for form
  final loginForm = GlobalKey<FormState>();

  //text field controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: Constant.paddingHorizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: loginForm,
                child: Column(
                  children: [
                    EmailField(controller: _emailController),
                    Constant.sizedBoxSpace,
                    PasswordField(controller: _passwordController),
                    Constant.sizedBoxSpace,
                    FilledButton(
                      style: Constant.fullWidthButton,
                      onPressed: () => login(context),
                      child: Text(l10n.login),
                    ),
                    OutlinedButton(
                        style: Constant.fullWidthButton,
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen())),
                        child: Text(l10n.signUp)),
                  ],
                ))
          ],
        ),
      )),
    );
  }

  //Actions
  login(context) {
    if (loginForm.currentState!.validate()) {
      BlocProvider.of<AppBloc>(context).add(
        LoginRequest(_emailController.text, _passwordController.text),
      );
    }
  }
}
