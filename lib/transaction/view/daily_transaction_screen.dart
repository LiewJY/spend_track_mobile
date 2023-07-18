import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/transaction/cubit/daily_transaction_cubit.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class DailyTransactionScreen extends StatefulWidget {
  const DailyTransactionScreen({super.key});

  @override
  State<DailyTransactionScreen> createState() => _DailyTransactionScreenState();
}

//todo make inot util
formatDate(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

class _DailyTransactionScreenState extends State<DailyTransactionScreen> {
  TextEditingController _dateInputController = TextEditingController();
  DateTime? selectedDate = DateTime.now();
  //double totalDailyTransactions = 0;

  @override
  void initState() {
    context.read<DailyTransactionCubit>().getDailyTransaction(selectedDate!);
    _dateInputController.addListener(_onDateInputChange);

    super.initState();
  }

  void _onDateInputChange() {
    String updatedDateTime = _dateInputController.text;
    log('updatedText     ' + updatedDateTime);
    log('selected date  ' + selectedDate.toString());

    //call function
    getData(updatedDateTime);
  }

  getData(String updatedDateTime) {
    DateTime newDateTime = DateFormat('dd-MM-yyyy').parse(updatedDateTime);
    context.read<DailyTransactionCubit>().getDailyTransaction(newDateTime);
  }

  @override
  void dispose() {
    _dateInputController.removeListener(_onDateInputChange);
    _dateInputController.dispose();
    super.dispose();
  }

  Map<String, List<MyTransaction>> categorizeTransactions(
      List<MyTransaction> transactions) {
    Map<String, List<MyTransaction>> categorizedTransactions = {};
    // Map<String, double> categorizedTotalTransactions = {};

    for (MyTransaction transaction in transactions) {
      if (categorizedTransactions.containsKey(transaction.category)) {
        categorizedTransactions[transaction.category]!.add(transaction);
        // totalDailyTransactions + transaction.amount!;
      } else {
        categorizedTransactions[transaction.category!] = [transaction];
        //totalDailyTransactions + transaction.amount!;
      }

      // if (categorizedTotalTransactions.containsKey(transaction.category)) {
      //   categorizedTotalTransactions[transaction.category!] =
      //       categorizedTotalTransactions[transaction.category]! +
      //           transaction.amount!;
      // } else {
      //   categorizedTotalTransactions[transaction.category!] =
      //       transaction.amount!;
      // }
    }

    return categorizedTransactions;
  }

  @override
  Widget build(BuildContext context) {
    _dateInputController.text = formatDate(DateTime.now());
    final l10n = context.l10n;

    return Padding(
      padding: AppStyle.paddingHorizontal,
      child: Column(
        children: [
          //todo make into component
          SizedBox(
            height: 8,
          ),
          TextFormField(
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.calendar_today_rounded)),
            controller: _dateInputController,
            readOnly: true,
            onTap: () async {
              DateTime? pick = await showDatePicker(
                  context: context,
                  initialDate: selectedDate!,
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now(),
                  currentDate: selectedDate);
              if (pick != null) {
                _dateInputController.text = formatDate(pick!);
                selectedDate = pick;
              }
            },
          ),
          AppStyle.sizedBoxSpace,
          BlocBuilder<DailyTransactionCubit, DailyTransactionState>(
            builder: (context, state) {
              if (state.status == DailyTransactionStatus.success &&
                  state.success == 'loadedData') {
                double totalDailyTransactions = state.transactionList.fold(
                  0,
                  (previousValue, transaction) =>
                      previousValue + transaction.amount!,
                );
                return Column(
                  children: [
                    Text(
                      '${l10n.totalSpending}: RM ${totalDailyTransactions.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AppStyle.sizedBoxSpace,
                  ],
                );
              }
              return SizedBox();
            },
          ),

          BlocBuilder<DailyTransactionCubit, DailyTransactionState>(
            builder: (context, state) {
              if (state.status == DailyTransactionStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(
                    value: 5,
                  ),
                );
              }

              if (state.status == DailyTransactionStatus.success &&
                  state.success == 'loadedData') {
                List<MyTransaction> transactions;
                transactions = context.select(
                    (DailyTransactionCubit bloc) => bloc.state.transactionList);
                //todo all content
                //todo chart
                // TransactionChart(data: state.monthlyTransactionSummary),

                if (transactions.isNotEmpty) {
                  //only sort by category when not empty
                  Map<String, List<MyTransaction>> groupedData;
                  groupedData = categorizeTransactions(transactions);
                  // groupedData.forEach((key, value) {
                  //   log(groupedData.toString());
                  // });

                  return Expanded(
                    child: ListView.builder(
                        // shrinkWrap: true,
                        // primary: false,
                        itemCount: groupedData.length,
                        itemBuilder: (_, index) {
                          String categoryName =
                              groupedData.keys.elementAt(index);
                          List<MyTransaction> groupedTransactions =
                              groupedData[categoryName]!;
                          //calculate the total for each category
                          double totalAmount = groupedTransactions.fold(
                            0,
                            (previousValue, transaction) =>
                                previousValue + transaction.amount!,
                          );

                          return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppStyle.sizedBoxSpace,
                                Padding(
                                  padding: AppStyle.paddingHorizontal,
                                  child: Text(
                                    '${l10n.category}: $categoryName',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Padding(
                                  padding: AppStyle.paddingHorizontal,
                                  child: Text(
                                    '${l10n.categoryTotal}: RM ${totalAmount.toStringAsFixed(2)}',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                Column(
                                  children: groupedTransactions
                                      .map(
                                        (item) => TransactionList(
                                          data: item,
                                        ),
                                      )
                                      .toList(),
                                ),
                                AppStyle.sizedBoxSpace,
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return Expanded(
                      child:
                          Center(child: Text(l10n.youDoNotHaveAnyTransaction)));
                }
              } else {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      value: 5,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
