import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/add/bloc/category_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/models/transactionSummary.dart';
import 'package:track/repositories/repos/category/category_repository.dart';
import 'package:track/repositories/repos/transaction/transaction_repository.dart';
import 'package:track/transaction/bloc/transaction_bloc.dart';
import 'package:track/transaction/cubit/monthly_transaction_summary_cubit.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

// var categoryList = [];

class TransactionScreenContent extends StatefulWidget {
  const TransactionScreenContent({super.key});

  @override
  State<TransactionScreenContent> createState() =>
      _TransactionScreenContentState();
}

class _TransactionScreenContentState extends State<TransactionScreenContent> {
  @override
  void initState() {
    // TODO: implement initState
    //load categories
    // context.read<CategoryBloc>().add(DisplayAllCategoryRequested());
    super.initState();
  }

  String selectedView = 'monthly';

  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final transactionRepository = TransactionRepository();
    final categoryRepository = CategoryRepository();
    // categoryList =
    //     context.select((CategoryBloc bloc) => bloc.state.categoryList);
    switchContent() {
      switch (selectedView) {
        case 'daily':
          log('daily');
          return DailyTransactionScreen();
        case 'monthly':
          log('monthly');

          return MonthlyTransactionContent();
        case 'yearly':
          log('yearly');

          return YearlyTransactionScreen();
        default:
          return DailyTransactionScreen();
      }
    }

    switchTitle() {
      switch (selectedView) {
        case 'daily':
          log('daily');
          return l10n.dailyTransaction;
        case 'monthly':
          log('monthly');

          return l10n.monthTransaction;
        case 'yearly':
          log('yearly');

          return l10n.yearlyTransaction;
        default:
          return l10n.monthTransaction;
      }
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TransactionBloc(transactionRepository: transactionRepository),
        ),
        BlocProvider(
          create: (context) => TransactionRangeCubit(transactionRepository),
        ),
        BlocProvider(
          create: (context) =>
              MonthlyTransactionSummaryCubit(transactionRepository),
        ),
        // BlocProvider(
        //   create: (context) =>
        //       CategoryBloc(categoryRepository: categoryRepository),
        // ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<TransactionBloc, TransactionState>(
            listener: (context, state) {
              if (state.status == TransactionStatus.failure) {
                switch (state.error) {
                  case 'cannotRetrieveData':
                    AppSnackBar.error(context, l10n.youDoNotHaveAnyTransaction);
                    break;
                }
              }
              if (state.status == TransactionStatus.success) {
                switch (state.success) {
                  case 'deleted':
                    AppSnackBar.success(context, l10n.transactionDeleteSuccess);
                    setState(() {
                      
                    });
                    break;
                  // case 'updated':
                  //   AppSnackBar.success(context, l10n.transactionUpdateSuccess);
                  //   break;
                }
              }
              //todo for success range
            },
          ),
          BlocListener<TransactionRangeCubit, TransactionRangeState>(
            listener: (context, state) {
              if (state.status == TransactionRangeStatus.failure) {
                switch (state.error) {
                  case 'cannotRetrieveData':
                    AppSnackBar.error(context, l10n.youDoNotHaveAnyTransaction);
                    break;
                }
              }
              //todo for success range
            },
          ),
          BlocListener<MonthlyTransactionSummaryCubit,
              MonthlyTransactionSummaryState>(
            listener: (context, state) {
              if (state.status == MonthlyTransactionSummaryStatus.failure) {
                switch (state.error) {
                  case 'cannotRetrieveData':
                    AppSnackBar.error(context, l10n.youDoNotHaveAnyTransaction);
                    break;
                }
              }
              //todo for success range
            },
          ),
        ],
        child: Scaffold(
            appBar: AppBar(
              title: Text(switchTitle()),
              actions: [
                PopupMenuButton(
                  icon: Icon(Icons.filter_list),
                  itemBuilder: (context) {
                    final l10n = context.l10n;
                    return [
                      PopupMenuItem(
                        value: 0,
                        child: Text(l10n.dailyView),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text(l10n.monthlyView),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(l10n.yearlyView),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    switch (value) {
                      case 0:
                        setState(() {
                          selectedView = 'daily';
                        });
                        break;
                      case 1:
                        setState(() {
                          selectedView = 'monthly';
                        });
                        break;
                      case 2:
                        setState(() {
                          selectedView = 'yearly';
                        });
                        break;
                    }
                  },
                )
              ],
            ),
            body: switchContent()),
      ),
    );
  }
}
