import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/utils/constant.dart';
import 'package:track/widgets/widgets.dart';

class UpdateNameModal extends StatefulWidget {
  const UpdateNameModal({super.key});

  @override
  State<UpdateNameModal> createState() => _UpdateNameModalState();
}

class _UpdateNameModalState extends State<UpdateNameModal> {
  final updateNameForm = GlobalKey<FormState>();

  //text field controllers
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      //this padding is for the keyboard
      padding: Constant.modalPadding,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 200,
          child: Form(
            key: updateNameForm,
            child: Column(
              children: [
                NameField(controller: _nameController),
                Constant.sizedBoxSpace,
                FilledButton(
                  style: Constant.fullWidthButton,
                  onPressed: () => updateName(),
                  child: Text(l10n.update),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //action
  void updateName() {
    if (updateNameForm.currentState!.validate()) {
      context
          .read<ManageAccountBloc>()
          .add(UpdateNameRequested(_nameController.text));
    }
  }
}
