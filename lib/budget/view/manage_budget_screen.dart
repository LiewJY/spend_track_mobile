import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/budget/bloc/budget_bloc.dart';
import 'package:track/budget/budget.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class ManageBudgetScreen extends StatefulWidget {
  const ManageBudgetScreen({super.key});

  @override
  State<ManageBudgetScreen> createState() => _ManageBudgetScreenState();
}

class _ManageBudgetScreenState extends State<ManageBudgetScreen> {
  final budgetRepository = BudgetRepository();
  final transactionRepository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BudgetBloc(budgetRepository: budgetRepository),
        ),
        // //todo add summary call
        // BlocProvider(
        //   create: (context) => TransactionRangeCubit(transactionRepository),
        // ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<BudgetBloc, BudgetState>(
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
                    AppSnackBar.success(context, l10n.budgetUpdateSuccess);
                    /// refresh();
                    break;
                  case 'deleted':
                     AppSnackBar.success(context, l10n.budgetDeleteSuccess);
                    // refresh();
                    break;
                  case 'loadedData':
                    //reload the data table when data is loaded
                    setState(() {});
                    break;
                }
              }
            },
          ),
          //todo add summary listener
          // BlocListener<SubjectBloc, SubjectState>(
          //   listener: (context, state) {
          //     // TODO: implement listener
          //   },
          // ),
        ],
        child: BudgetContent(),
      ),
    );
  }
}

class BudgetContent extends StatefulWidget {
  const BudgetContent({
    super.key,
  });

  @override
  State<BudgetContent> createState() => _BudgetContentState();
}

class _BudgetContentState extends State<BudgetContent> {
  List<Budget> budgets = [];

  DateTime now = DateTime.now();
  @override
  void initState() {
    //initial call
    context.read<BudgetBloc>().add(DisplayBudgetRequested());
    super.initState();
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
                MaterialPageRoute(builder: (context) => BudgetListScreen()),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppStyle.paddingHorizontal,
              child: BlocBuilder<BudgetBloc, BudgetState>(
                builder: (context, state) {
                  if (state.status == BudgetStatus.success &&
                      state.success == 'loadedData') {
                    double totalMonthlyBudget = 0;
                    for (var budget in budgets) {
                      totalMonthlyBudget = totalMonthlyBudget + budget.amount!;
                    }
                    return Column(
                      children: [
                        BudgetChart(
                          data: budgets,
                          totalBudget: totalMonthlyBudget,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.totalMonthlyBudget,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              'RM${totalMonthlyBudget.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text(l10n.youDoNotHaveAnyBudget));
                  }
                },
              ),
            ),
            Padding(
              padding: AppStyle.paddingHorizontal,
              child: Text(
                l10n.budgetByCategory,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BlocBuilder<BudgetBloc, BudgetState>(
              builder: (context, state) {
                if (state.status == BudgetStatus.success &&
                    state.success == 'loadedData') {
                  if (budgets.isEmpty) {
                    //if empty return empty text
                    return Center(child: Text(l10n.youDoNotHaveAnyBudget));
                  }
                  return ListView.builder(
                      itemCount: budgets.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return BudgetList(data: budgets[index]);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: 5,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
