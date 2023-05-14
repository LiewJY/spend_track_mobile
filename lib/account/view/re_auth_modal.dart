import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/login/login.dart';
import 'package:track/sign_up/sign_up.dart';
import 'package:track/utils/constant.dart';
import 'package:track/widgets/widgets.dart';
//todo not in used, may need to remove
class ReAuthModal extends StatefulWidget {
  const ReAuthModal({super.key});

  @override
  State<ReAuthModal> createState() => _ReAuthModalState();
}

class _ReAuthModalState extends State<ReAuthModal> {
  final reAuthModalForm = GlobalKey<FormState>();

  //text field controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: Constant.modalPadding,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 300,
          child: Form(
            key: reAuthModalForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      l10n.reAuth,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Constant.sizedBoxSpace,
                EmailField(
                  controller: _emailController,
                  textInputAction: 'next',
                ),
                Constant.sizedBoxSpace,
                PasswordField(controller: _passwordController),
                Constant.sizedBoxSpace,
                FilledButton(
                  style: Constant.fullWidthButton,
                  onPressed: () => reAuth(),
                  child: Text(l10n.next),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //action
  void reAuth() {
    if (reAuthModalForm.currentState!.validate()) {
      context.read<ManageAccountBloc>().add(
          ReAuthRequested(_emailController.text, _passwordController.text));
    }
  }
}
