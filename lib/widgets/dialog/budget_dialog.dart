import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/wallet/cubit/available_wallet_cubit.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/widgets/form_field/amount_field.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class BudgetDialog extends StatefulWidget {
  const BudgetDialog({
    super.key,
    required this.dialogTitle,
    required this.actionName,
    required this.action,
    this.data,
  });

  final String dialogTitle;
  final String actionName;
  final String action;
  final SpendingCategory? data;

  @override
  State<BudgetDialog> createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {
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
                    Text(
                      widget.dialogTitle,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      l10n.addingBudget(widget.data!.name.toString()),
                      style: Theme.of(context).textTheme.bodyLarge,
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

  double? stringToDouble(value) {
    return double.tryParse(value);
  }

  action(type) {
    if (budgetForm.currentState!.validate()) {
      switch (type) {
        case 'addToMyBudget':
          log('ressdsd');
          final storeBudget = Budget(
            name: widget.data!.name,
            // categoryId: widget.data!.uid,
            amount: stringToDouble(_amountController.text),
          );

          context.read<AvailableBudgetCubit>().addToMyBudgets(
                budget: storeBudget,
                documentId: widget.data!.uid,
              );
          break;
      }
    }
  }
}
