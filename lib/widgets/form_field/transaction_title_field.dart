import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:track/l10n/l10n.dart';

class TransactionTitleField extends StatefulWidget {
  const TransactionTitleField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<TransactionTitleField> createState() => _TransactionTitleFieldState();
}

class _TransactionTitleFieldState extends State<TransactionTitleField> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    String? nameValidator(value) {
      if (value.length >= 2 && value != null) {
        return null;
      } else {
        return l10n.nameEmpty;
      }
    }

    return TextFormField(
      decoration: InputDecoration(
        labelText: "${l10n.transactionName}*",
      ),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      validator: nameValidator,
    );
  }
}
