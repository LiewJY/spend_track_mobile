import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';


class EmailField extends StatefulWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;
  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    String? emailValidator(value) {
      if (value.isEmpty) {
        return l10n.pleaseEnterEmail;
      }

      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9.!#$%&'
        r'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
      );

      if (!emailRegex.hasMatch(value)) {
        return l10n.invalidEmail;
      }

      return null;
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: "${l10n.email}*",
      ),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
    );
  }
}
