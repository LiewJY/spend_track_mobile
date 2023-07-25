import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/wallet/cubit/available_wallet_cubit.dart';
import 'package:track/budget/bloc/budget_bloc.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/widgets/form_field/amount_field.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class EditBudgetDialog extends StatefulWidget {
  const EditBudgetDialog({
    super.key,
    required this.dialogTitle,
    // required this.actionName,
    //required this.action,
    this.data,
  });

  final String dialogTitle;
  // final String actionName;
  // final String action;
  final Budget? data;

  @override
  State<EditBudgetDialog> createState() => _EditBudgetDialogState();
}

class _EditBudgetDialogState extends State<EditBudgetDialog> {
  final budgetForm = GlobalKey<FormState>();
  late final String uid;
  final _amountController = TextEditingController();
  // final _cardNumberController = TextEditingController();
  // final _cardBudgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //set data for edit / update option
    // if (widget.action == 'editCategory') {
    //   _nameController.text = widget.data!.name!;
    //   _descriptionController.text = widget.data!.description!;
    // }
    _amountController.text = widget.data!.amount!.toStringAsFixed(2);

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyle.modalPadding,
          child: Form(
            key: budgetForm,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.dialogTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.editingBudget(widget.data!.name.toString()),
                        style: Theme.of(context).textTheme.bodyLarge,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                AppStyle.sizedBoxSpace,
                AmountField(
                    controller: _amountController, label: l10n.budgetAmount),
                AppStyle.sizedBoxSpace,
                // AppStyle.sizedBoxSpace,
                // AmountField(
                //   controller: _cardBudgetController,
                //   label: l10n.budget,
                // ),
                AppStyle.sizedBoxSpace,
                FilledButton(
                  style: AppStyle.fullWidthButton,
                  onPressed: () {
                    save();
                  },
                  child: Text(l10n.save),
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

  double stringToDouble(value) {
    return double.parse(value);
  }

  save() {
    // log('save budget ' + widget.data.toString());
    context.read<BudgetBloc>().add(UpdateBudgetRequested(
          uid: widget.data!.uid!,
          amount: stringToDouble(_amountController.text),
        ));
    Navigator.of(context, rootNavigator: true).pop();
  }

  // action(type) {
  //   if (budgetForm.currentState!.validate()) {
  //     switch (type) {
  //       case 'addToMyBudget':
  //         final storeBudget = Budget(
  //           name: widget.data!.name,
  //           color: widget.data!.color,
  //           amount: stringToDouble(_amountController.text),
  //         );

  //         context.read<AvailableBudgetCubit>().addToMyBudgets(
  //               budget: storeBudget,
  //               documentId: widget.data!.uid,
  //             );
  //         break;
  //     }
  //   }
  // }
}
