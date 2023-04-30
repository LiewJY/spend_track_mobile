import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/uitls/constant.dart';
import 'package:track/widgets/widgets.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final signUpForm = GlobalKey<FormState>();

  //text field controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Form(
      key: signUpForm,
      child: Column(
        children: [
          Constant.sizedBoxSpace,
          NameField(controller: _nameController),
          Constant.sizedBoxSpace,
          EmailField(controller: _emailController),
          Constant.sizedBoxSpace,
          PasswordField(controller: _passwordController),
          Constant.sizedBoxSpace,
          ConfirmPasswordField(controller: _confirmPasswordController),
          Constant.sizedBoxSpace,
          FilledButton(
            style: Constant.fullWidthButton,
            onPressed: () => signUp(),
            child: Text(l10n.signUp),
          ),
          OutlinedButton(
            style: Constant.fullWidthButton,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }
  //action
  void signUp() {
    //todo

  }
}
