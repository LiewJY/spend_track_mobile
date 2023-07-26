import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/budget/bloc/budget_bloc.dart';
import 'package:track/budget/budget.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/budget/cubit/view_monthly_budget_cubit.dart';
import 'package:track/budget/view/manage_budget_screen.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/transaction/cubit/monthly_transaction_summary_cubit.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class BudgetScreenContent extends StatefulWidget {
  const BudgetScreenContent({super.key});

  @override
  State<BudgetScreenContent> createState() => _BudgetScreenContentState();
}

class _BudgetScreenContentState extends State<BudgetScreenContent> {
  final budgetRepository = BudgetRepository();
  final transactionRepository = TransactionRepository();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionRangeCubit(transactionRepository),
        ),
        BlocProvider(
          create: (context) =>
              ViewMonthlyBudgetCubit(budgetRepository, transactionRepository),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TransactionRangeCubit, TransactionRangeState>(
            listener: (context, state) {
              if (state.status == TransactionRangeStatus.failure) {
                switch (state.error) {
                  case 'cannotRetrieveData':
                    AppSnackBar.error(context, l10n.youDoNotHaveAnyBudget);
                    break;
                }
              }
              //todo for success range
            },
          ),
          BlocListener<ViewMonthlyBudgetCubit, ViewMonthlyBudgetState>(
            listener: (context, state) {
              if (state.status == ViewMonthlyBudgetStatus.failure) {
                switch (state.error) {
                  case 'cannotRetrieveData':
                    AppSnackBar.error(context, l10n.youDoNotHaveAnyBudget);
                    break;
                }
              }
              //todo for success range
            },
          ),
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
  String selectedYearMonth = '';
  List<Budget> monthlyBudget = [];

  DateTime now = DateTime.now();
  @override
  void initState() {
    context.read<TransactionRangeCubit>().getTransactionRange();

    super.initState();
  }

  translateYYYY_MM(String input) {
    List<String> separated = input.split('_');
    int month = int.parse(separated[1]);
    int year = int.parse(separated[0]);

    DateTime dateTime = DateTime(year, month);
    String formattedDate = DateFormat('MMMM yyyy').format(dateTime);
    return formattedDate;
  }

  loadSelectedMonth(String yearMonth) {
    context.read<ViewMonthlyBudgetCubit>().getMyMonthlyBudgets(yearMonth);
  }

//todo move to utils
  formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    // content =
    List<String> content =
        context.select((TransactionRangeCubit bloc) => bloc.state.rangeList);

    monthlyBudget = context
        .select((ViewMonthlyBudgetCubit bloc) => bloc.state.monthlyBudgetList);
    //log(monthlyBudget.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.budget),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageBudgetScreen()),
              );
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<TransactionRangeCubit>().getTransactionRange();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //todo monthly transaction list thing same

              //todo make into component
              SizedBox(
                height: 8,
              ),
              //horizontal list for transaction month selection
              SizedBox(
                width: double.infinity,
                height: 35,
                child:
                    BlocBuilder<TransactionRangeCubit, TransactionRangeState>(
                  builder: (context, state) {
                    if (state.status == TransactionRangeStatus.success &&
                        state.success == 'loadedTransactionRange') {
                      //preselect the latest and load the data
                      if (selectedYearMonth.isEmpty && content.isNotEmpty) {
                        selectedYearMonth = content.last;
                      }
                      loadSelectedMonth(selectedYearMonth.toString());
                      // log("${selectedYearMonth}selected");
                      return ListView.builder(
                          //reverse: true,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: content.length,
                          itemBuilder: (_, index) {
                            bool isSelected =
                                selectedYearMonth == content[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: isSelected
                                  ? FilledButton(
                                      onPressed: () {
                                        log(content[index]);
                                        setState(() {
                                          selectedYearMonth = content[index];
                                        });
                                        log("${selectedYearMonth}selected wewe");
                                        loadSelectedMonth(
                                            selectedYearMonth.toString());
                                      },
                                      child: Text(
                                        translateYYYY_MM(content[index]),
                                      ),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        log(content[index]);
                                        setState(() {
                                          selectedYearMonth = content[index];
                                        });
                                        log("${selectedYearMonth}selected wewe");
                                        loadSelectedMonth(
                                            selectedYearMonth.toString());
                                      },
                                      child: Text(
                                        translateYYYY_MM(content[index]),
                                      ),
                                    ),
                            );
                          });
                    } else {
                      //todo make into conponent
                      return Center(
                        child: CircularProgressIndicator(
                          value: 5,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: AppStyle.paddingHorizontal,
                child:
                    BlocBuilder<ViewMonthlyBudgetCubit, ViewMonthlyBudgetState>(
                  builder: (context, state) {
                    if (state.status == ViewMonthlyBudgetStatus.success &&
                        state.success == 'loadedData') {
                      double totalMonthlyBudget = 0;
                      double overBudget = 0;

                      for (var budget in monthlyBudget) {
                        totalMonthlyBudget =
                            totalMonthlyBudget + budget.amount!;
                      }
                      overBudget =
                          totalMonthlyBudget - state.monthlySpendingTotal;

                      return Column(
                        children: [
                          BudgetExpensesChart(
                            data: monthlyBudget,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                l10n.remainingMonthlyBudget,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              if (overBudget <= 0) ...[
                                Text(
                                  'RM ${overBudget.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ),
                                      ),
                                ),
                              ] else ...[
                                Text(
                                  'RM ${overBudget.toStringAsFixed(2)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.merge(
                                        TextStyle(
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                ),
                              ],
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
                  l10n.budgetVsSpendingByCategory,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              //todo budget and its expenses
              BlocBuilder<ViewMonthlyBudgetCubit, ViewMonthlyBudgetState>(
                builder: (context, state) {
                  if (state.status == ViewMonthlyBudgetStatus.success &&
                      state.success == 'loadedData') {
                    if (monthlyBudget.isEmpty) {
                      //if empty return empty text
                      return Center(child: Text(l10n.youDoNotHaveAnyBudget));
                    }
                    return ListView.builder(
                        itemCount: monthlyBudget.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (_, index) {
                          log('ddddd   ' + monthlyBudget[index].toString());
                          return BudgetListView(data: monthlyBudget[index]);
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
      ),
    );
  }
}
