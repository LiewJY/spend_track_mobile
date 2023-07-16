import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/widgets/widgets.dart';

class BudgetList extends StatelessWidget {
  const BudgetList({
    super.key,
    required this.data,
  });

  // final onPressed;
  final Budget data;

  //actions
  edit() {
    log('edit budget ');
    //todo
  }

  delete() {
    log('delete budget ');
    //todo
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
   // double remainingBudget = data.amount! - data.amountSpent!;
    return ListTile(
        title: Text(data.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                '${l10n.monthlyBudget}: RM ${data.amount!.toStringAsFixed(2)}'),
            // if (remainingBudget <= 0) ...[
            //   Text(
            //     '${l10n.remainingMonthlyBudget}: RM ${remainingBudget.toStringAsFixed(2)}',
            //     style: TextStyle(
            //       color: Theme.of(context).colorScheme.error,
            //     ),
            //   ),
            // ] else ...[
            //   Text(
            //     '${l10n.remainingMonthlyBudget}: RM ${remainingBudget.toStringAsFixed(2)}',
            //     style: TextStyle(
            //       color: Colors.green.shade800,
            //     ),
            //   ),
            // ]
          ],
        ),
        //todo make this into dropdown that allow delete and edit
        //todo implement
        trailing: PopupMenuButton(
          icon: Icon(Icons.more_vert_rounded),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text(l10n.edit),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(l10n.delete),
              ),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case 0:
                edit();
                break;
              case 1:
                delete();
                break;
            }
          },
        )

        //IconButton(onPressed: onPressed, icon: Icon(Icons.more_vert_rounded)),
        );
  }
}
