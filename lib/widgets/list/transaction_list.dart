import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/transaction/view/edit_transaction_screen.dart';
import 'package:track/widgets/widgets.dart';

//for dialog
bool isDialogOpen = false;
void toggleDialog() {
  isDialogOpen = !isDialogOpen;
}

class TransactionList extends StatelessWidget {
  const TransactionList({super.key, required this.data});

  final MyTransaction data;

  //actions
  edit(BuildContext context, MyTransaction data) {
    log('edit transaction ');
    final l10n = context.l10n;
    //todo
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditTransactionScreen(
              data: data,
            )));

    // if (!isDialogOpen) {
    //   showDialog(
    //       context: context,
    //       builder: (_) {
    //         return DeleteConfirmationDialog(
    //             data: data,
    //             description: l10n.deletingTransaction(data.name!),
    //             dialogTitle: l10n.delete,
    //             action: () {
    //               context
    //                   .read<TransactionBloc>()
    //                   .add(DeleteTransactionRequested(data: data));
    //               Navigator.of(context, rootNavigator: true).pop();
    //             });
    //       }).then((value) {
    //     toggleDialog();
    //   });
    //   toggleDialog();
    // }
  }

  delete(BuildContext context, MyTransaction data) {
    final l10n = context.l10n;
    if (!isDialogOpen) {
      showDialog(
          context: context,
          builder: (_) {
            return DeleteConfirmationDialog(
                data: data,
                description: l10n.deletingTransaction(data.name!),
                dialogTitle: l10n.delete,
                action: () {
                  context
                      .read<TransactionBloc>()
                      .add(DeleteTransactionRequested(data: data));
                  Navigator.of(context, rootNavigator: true).pop();
                });
          }).then((value) {
        toggleDialog();
      });
      toggleDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    formatDate(DateTime dateTime) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    return ListTile(
        title: Text(
          data.name!,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RM ${data.amount!.toStringAsFixed(2)}'),
            Text('${l10n.category}: ${data.category}'),
            Text('${l10n.fundSource}: ${data.fundSourceCustom}'),
            if (data.note!.isNotEmpty) ...[Text('${l10n.note}: ${data.note}')]
          ],
        ),
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
                edit(context, data);
                break;
              case 1:
                delete(context, data);
                break;
            }
          },
        )

        // IconButton(onPressed: onPressed, icon: Icon(Icons.more_vert_rounded)),
        );
  }
}
