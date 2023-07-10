import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class CardDialog extends StatefulWidget {
  const CardDialog({
    super.key,
    required this.dialogTitle,
    required this.actionName,
    required this.action,
    this.data,
  });

  final String dialogTitle;
  final String actionName;
  final String action;
  final CreditCard? data;

  @override
  State<CardDialog> createState() => _CardDialogState();
}

class _CardDialogState extends State<CardDialog> {
  final cardForm = GlobalKey<FormState>();
  late final String uid;
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //set data for edit / update option
    // if (widget.action == 'editCategory') {
    //   _nameController.text = widget.data!.name!;
    //   _descriptionController.text = widget.data!.description!;
    // }

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
                    Text(
                      widget.dialogTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      l10n.adding(widget.data!.name.toString()),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                AppStyle.sizedBoxSpace,
                NameField(controller: _nameController),
                AppStyle.sizedBoxSpace,
                CardNumberField(
                    controller: _cardNumberController,
                    label: l10n.last4DigitOfCard),
                AppStyle.sizedBoxSpace,

                FilledButton(
                  style: AppStyle.fullWidthButton,
                  onPressed: () => action(widget.action),
                  child: Text(widget.actionName),
                ),
                //  AppStyle.sizedBoxSpace,
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

  action(type) {
    if (cardForm.currentState!.validate()) {
      switch (type) {
        case 'addToMyCard':
          context.read<AvailableCardCubit>().addToMyCards(card: widget.data,
          customName: _nameController.text,
          lastNumber: _cardNumberController.text);
          break;
      }
      //   switch (type) {
      //     case 'addCategory':
      //       context.read<CategoryBloc>().add(AddCategoryRequested(
      //             name: _nameController.text,
      //             description: _descriptionController.text,
      //           ));
      //       break;
      //     case 'editCategory':
      //       context.read<CategoryBloc>().add(UpdateCategoryRequested(
      //             uid: widget.data!.uid!,
      //             name: _nameController.text,
      //             description: _descriptionController.text,
      //           ));
      //       break;
      //   }
    }
  }
}
