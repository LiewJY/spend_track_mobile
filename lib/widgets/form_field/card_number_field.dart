import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:track/l10n/l10n.dart';

class CardNumberField extends StatefulWidget {
  const CardNumberField(
      {super.key, required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  State<CardNumberField> createState() => _CardNumberFieldState();
}

class _CardNumberFieldState extends State<CardNumberField> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    String? amountValidator(value) {
      if (value.length == 4 && value != null) {
        return null;
      } else {
        return l10n.pleaseProvideLast4DigitOfCard;
      }
    }

    return TextFormField(
      inputFormatters: [LengthLimitingTextInputFormatter(4)],
      decoration: InputDecoration(
        labelText: "${widget.label}*",
      ),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.number,
      validator: amountValidator,
    );
  }
}
