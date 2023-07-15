import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/budget/bloc/budget_bloc.dart';
import 'package:track/budget/budget.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class BudgetScreenContent extends StatefulWidget {
  const BudgetScreenContent({super.key});

  @override
  State<BudgetScreenContent> createState() => _BudgetScreenContentState();
}

class _BudgetScreenContentState extends State<BudgetScreenContent> {
  final budgetRepository = BudgetRepository();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocProvider(
      create: (context) => BudgetBloc(budgetRepository: budgetRepository),
      child: BlocListener<BudgetBloc, BudgetState>(
        listener: (context, state) {
          if (state.status == BudgetStatus.failure) {
            switch (state.error) {
              case 'cannotRetrieveData':
                AppSnackBar.error(context, l10n.cannotRetrieveData);
                break;
            }
          }
          //todo
          if (state.status == BudgetStatus.success) {
            switch (state.success) {
              case 'updated':
                // if (isDialogOpen) {
                //   Navigator.of(context, rootNavigator: true).pop();
                // }
                // AppSnackBar.success(context, l10n.walletUpdateSuccess);
                // refresh();
                break;
              case 'deleted':
                // AppSnackBar.success(context, l10n.walletDeleteSuccess);
                // refresh();
                break;
              case 'loadedData':
                //reload the data table when data is loaded
                setState(() {});
                break;
            }
          }
        },
        child: Content(),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({
    super.key,
  });

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Budget> budgets = [];

  @override
  void initState() {
    //initial call
    context.read<BudgetBloc>().add(DisplayBudgetRequested());
    super.initState();
  }

  refresh() {
    //call load data function
    context.read<BudgetBloc>().add(DisplayBudgetRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    budgets = context.select((BudgetBloc bloc) => bloc.state.budgetList);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myBudget),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AvailableBudgetListScreen()),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: AppStyle.paddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //todo graph
            Text(
              l10n.overview,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // Text("BudgetScreenContent"),
            //todo total monthly budget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.totalMonthlyBudget,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'RM${'0.00'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            //todo list view of all budget categories
            Text(
              l10n.budgetByCategory,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            //todo budget and its expenses
            Expanded(
              child: BlocBuilder<BudgetBloc, BudgetState>(
                builder: (context, state) {
                  //todo fix addd if stateem
                  return budgets.isNotEmpty
                      ? ListView.builder(
                          itemCount: budgets.length,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            return BudgetList(data: budgets[index]);
                          })
                      : Center(
                          child: Text(l10n.youDoNotHaveAnyBudget),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
