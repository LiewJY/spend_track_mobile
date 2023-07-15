import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/transaction/cubit/monthly_transaction_summary_cubit.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class MonthlyTransactionContent extends StatefulWidget {
  const MonthlyTransactionContent({
    super.key,
  });

  @override
  State<MonthlyTransactionContent> createState() => _MonthlyTransactionContentState();
}

class _MonthlyTransactionContentState extends State<MonthlyTransactionContent> {
  String? selected;
  List<MyTransaction> transactions = [];
  @override
  void initState() {
    // context.read<transaction>().add(DisplayTransactionRangeRequested());
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
    //todo
    context
        .read<TransactionBloc>()
        .add(DisplayTransactionRequested(yearMonth: yearMonth));
    //todo add the summary
    context
        .read<MonthlyTransactionSummaryCubit>()
        .getMonthlyTransactionSummary(yearMonth);
  }

  //grouping data into its dates
  Map<DateTime, List<MyTransaction>> groupDataByDate(dataList) {
    Map<DateTime, List<MyTransaction>> groupedData = {};
    for (var item in dataList) {
      DateTime date = item.date;
      if (!groupedData.containsKey(date)) {
        groupedData[date] = [];
      }
      groupedData[date]!.add(item);
    }
    return groupedData;
  }

//todo move to utils
  formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo
    // content =
    List<String> content =
        context.select((TransactionRangeCubit bloc) => bloc.state.rangeList);

// //add to anither
    // TransactionSummary monthlyTransactionSummary = context.select(
    //     (MonthlyTransactionSummaryCubit bloc) =>
    //         bloc.state.monthlyTransactionSummary);
//      log('ss' +  monthlyTransactionSummary.toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //todo make into component
        SizedBox(
          height: 8,
        ),
        //horizontal list for transaction month selection
        SizedBox(
          width: double.infinity,
          height: 35,
          child: BlocBuilder<TransactionRangeCubit, TransactionRangeState>(
            builder: (context, state) {
              if (state.status == TransactionRangeStatus.success &&
                  state.success == 'loadedTransactionRange') {
                //preselect the latest and load the data
                if (content.isNotEmpty) {
                  selected = content.last;
                }
                loadSelectedMonth(selected.toString());
                log("${selected}selected");
                return ListView.builder(
                    //reverse: true,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: content.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: OutlinedButton(
                          onPressed: () {
                            log(content[index]);
                            selected = content[index];
                            log("${selected}selected wewe");
                            loadSelectedMonth(selected.toString());
                          },
                          child: Text(translateYYYY_MM(content[index])),
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
        AppStyle.sizedBoxSpace,
        //todo graph (show percentage of each category spending) add inbnto the bloc builder also
// monthlyTransactionSummary
        //todo total monthly budget
        BlocBuilder<MonthlyTransactionSummaryCubit,
            MonthlyTransactionSummaryState>(
          builder: (context, state) {
            log('jk ' + state.monthlyTransactionSummary.toString());
            return Padding(
              padding: AppStyle.paddingHorizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.totalMonthlyTransaction,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'RM${state.monthlyTransactionSummary.totalSpending?.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          },
        ),

        //vertical scrolling list for month's transaction
        Expanded(
          child: Padding(
            padding: AppStyle.paddingHorizontal,
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state.status == TransactionStatus.success &&
                    state.success == 'loadedData') {
                  log('reloaddata');
                  transactions = context.select(
                      (TransactionBloc bloc) => bloc.state.transactionList);
                  transactions.forEach((element) {
                    log('fffm  ' + element.toString());
                  });
                  Map<DateTime, List<MyTransaction>> groupedData =
                      groupDataByDate(transactions);

                  if (content.isEmpty) {
                    //if empty return empty text
                    return Center(child: Text(l10n.youDoNotHaveAnyTransaction));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: groupedData.length,
                      itemBuilder: (_, index) {
                        DateTime date = groupedData.keys.elementAt(index);
                        List<MyTransaction> groupedTransactions =
                            groupedData[date]!;
                        return Column(
                          children: [
                            Text(formatDate(date) +
                                ', ' +
                                DateFormat('EEEE').format(date).toString()),
                            Column(
                              children: groupedTransactions
                                  .map(
                                    (item) => TransactionList(
                                      onPressed: () {
                                        //todo
                                        log('sadsad');
                                      },
                                      data: item,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        );
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
          ),
        ),
      ],
    );
  }
}
