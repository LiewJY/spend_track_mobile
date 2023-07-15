import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/widgets/widgets.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.onPressed, required this.data});

  final onPressed;
  final MyTransaction data;

  //actions
  edit() {
    log('edit transaction ');
    //todo
  }

  delete() {
    log('delete transaction ');
    //todo
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    formatDate(DateTime dateTime) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    return ListTile(
        title: Text(data.name!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('RM ${data.amount!.toStringAsFixed(2)}'),
            Text('${l10n.category}: ${data.category}'),
            //add note field here
          ],
        ),
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

        // IconButton(onPressed: onPressed, icon: Icon(Icons.more_vert_rounded)),
        );
  }
}
