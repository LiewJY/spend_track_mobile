import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:track/l10n/l10n.dart';

class NoteField extends StatefulWidget {
  const NoteField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<NoteField> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // String? nameValidator(value) {
    //   if (value.length >= 2 && value != null) {
    //     return null;
    //   } else {
    //     return l10n.nameEmpty;
    //   }
    // }

    return TextFormField(
      decoration: InputDecoration(
        labelText: "${l10n.note}",
      ),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.multiline,
      //validator: nameValidator,
    );
  }
}
