import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';

import '../../uitls/constant.dart';
import '../../uitls/validation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //for password
  bool obscurePassword = true;
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "${l10n.email}*",
                      ),
                      controller: _emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validation.emailValidator,
                    ),
                    Constant.sizedBoxSpace,
                    TextFormField(
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                          labelText: "${l10n.password}*",
                          suffixIcon: IconButton(
                            icon: Icon(obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          )),
                      controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validation.passwordValidator,
                    ),
                    Constant.sizedBoxSpace,
                    ElevatedButton(
                        onPressed: () {
                          login(context);
                        },
                        child: Text(l10n.login))
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
