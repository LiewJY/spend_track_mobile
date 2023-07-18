import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/budget/bloc/budget_bloc.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/widgets/widgets.dart';

//for dialog
bool isBudgetListDialogOpen = false;
void toggleBudgetListDialog() {
  isBudgetListDialogOpen = !isBudgetListDialogOpen;
}

class BudgetList extends StatelessWidget {
  const BudgetList({
    super.key,
    required this.data,
  });

  // final onPressed;
  final Budget data;

  // BudgetRepository budgetRepository;
  //actions
  edit(BuildContext context, Budget dat) {
    log('edit budget ');
    //todo
    final l10n = context.l10n;
    if (!isBudgetListDialogOpen) {
      showDialog(
          context: context,
          builder: (_) {
            return RepositoryProvider(
              create: (context) => BudgetRepository(),
              child: BlocProvider.value(
                value: BlocProvider.of<BudgetBloc>(context),
                child:
                    EditBudgetDialog(dialogTitle: l10n.editBudget, data: data),
              ),
            );
            // return DeleteConfirmationDialog(
            //     data: data,
            //     description: 'weeewrewrwe',
            //     dialogTitle: l10n.delete,
            //     action: () {
            //       context
            //           .read<BudgetBloc>().add(DeleteBudgetRequested(uid: data.uid!));
            //       Navigator.of(context, rootNavigator: true).pop();
            //     });
          }).then((value) {
        toggleBudgetListDialog();
      });
      toggleBudgetListDialog();
    }
  }

  delete(BuildContext context, Budget data) {
    final l10n = context.l10n;
    if (!isBudgetListDialogOpen) {
      showDialog(
          context: context,
          builder: (_) {
            return DeleteConfirmationDialog(
                data: data,
                description: l10n.deletingBudget(data.name!),
                dialogTitle: l10n.delete,
                action: () {
                  context
                      .read<BudgetBloc>()
                      .add(DeleteBudgetRequested(uid: data.uid!));
                  Navigator.of(context, rootNavigator: true).pop();
                });
          }).then((value) {
        toggleBudgetListDialog();
      });
      toggleBudgetListDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // double remainingBudget = data.amount! - data.amountSpent!;
    return BlocListener<BudgetBloc, BudgetState>(
      listener: (context, state) {
        if (state.status == BudgetStatus.success) {
          switch (state.success) {
            case 'updated':
              if (isBudgetListDialogOpen) {
                Navigator.of(context, rootNavigator: true).pop();
              }
              AppSnackBar.success(context, l10n.budgetUpdateSuccess);
              /// refresh();
              break;

          }
        }
      },
      child: ListTile(
          title: Text(data.name!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${l10n.monthlyBudget}: RM ${data.amount!.toStringAsFixed(2)}'),
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
                  edit(context, data);
                  break;
                case 1:
                  delete(context, data);
                  break;
              }
            },
          )

          //IconButton(onPressed: onPressed, icon: Icon(Icons.more_vert_rounded)),
          ),
    );
  }
}
