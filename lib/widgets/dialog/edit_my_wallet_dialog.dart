import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/card/cubit/card_cashback_cubit.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/widgets/form_field/amount_field.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class EditMyWalletDialog extends StatefulWidget {
  const EditMyWalletDialog({
    super.key,
    required this.dialogTitle,
    // required this.actionName,
    // required this.action,
    this.data,
  });

  final String dialogTitle;
  // final String actionName;
  // final String action;
  final Wallet? data;

  @override
  State<EditMyWalletDialog> createState() => _EditMyWalletDialogState();
}

class _EditMyWalletDialogState extends State<EditMyWalletDialog> {
  final cardForm = GlobalKey<FormState>();

  ///late final String uid;
  final _nameController = TextEditingController();
  List<Cashback> cashbacks = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //populate textfield
    _nameController.text = widget.data!.customName!;

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyle.modalPadding,
          child: Form(
            key: cardForm,
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dialogTitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          '${l10n.wallet}: ${widget.data!.name}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${l10n.description}: ${widget.data!.description}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
                AppStyle.sizedBoxSpace,
                NameField(controller: _nameController),
                AppStyle.sizedBoxSpace,
                FilledButton(
                  style: AppStyle.fullWidthButton,
                  onPressed: () => save(),
                  child: Text(l10n.save),
                ),
                OutlinedButton(
                  style: AppStyle.fullWidthButton,
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.cancel),
                ),
                AppStyle.sizedBoxSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() {
    if (cardForm.currentState!.validate()) {
      context.read<WalletBloc>().add(UpdateWalletRequested(
            uid: widget.data!.uid!,
            customName: _nameController.text,
          ));
    }
  }
}
