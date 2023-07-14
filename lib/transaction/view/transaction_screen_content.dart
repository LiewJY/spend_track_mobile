import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/repos/transaction/transaction_repository.dart';
import 'package:track/transaction/bloc/transaction_bloc.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class TransactionScreenContent extends StatelessWidget {
  const TransactionScreenContent({super.key});
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final transactionRepository = TransactionRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TransactionBloc(transactionRepository: transactionRepository),
        ),
        BlocProvider(
          create: (context) => TransactionRangeCubit(transactionRepository),
        ),
      ],
      child: BlocListener<TransactionRangeCubit, TransactionRangeState>(
        listener: (context, state) {
          if (state.status == TransactionRangeStatus.failure) {
            switch (state.error) {
              case 'cannotRetrieveData':
                AppSnackBar.error(context, l10n.cannotRetrieveData);
                break;
            }
          }
          //todo for success range
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.transaction),
            ),
            body: Padding(
              padding: AppStyle.paddingHorizontal,
              child: TransactionContent(),
            )),
      ),
    );
  }
}

class TransactionContent extends StatefulWidget {
  const TransactionContent({
    super.key,
  });

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
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

  loadSelectedMonth(String collectionName) {
    //todo
    context
        .read<TransactionBloc>()
        .add(DisplayTransactionRequested(yyyyMm: collectionName));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo
    // content =
    List<String> content =
        context.select((TransactionRangeCubit bloc) => bloc.state.rangeList);

    // content.forEach((f) {
    //   log('sds ' + f);
    // });

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
                selected = content.last;
                loadSelectedMonth(selected!);
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
                            log("${selected}selected");
                          },
                          child: Text(translateYYYY_MM(content[index])),
                        ),
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
        AppStyle.sizedBoxSpace,
        //todo graph (show percentage of each category spending)

        //vertical scrolling list for month's transaction
        Expanded(child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state.status == TransactionStatus.success &&
                state.success == 'loadedData') {
              transactions = context
                  .select((TransactionBloc bloc) => bloc.state.transactionList);
              transactions.forEach((element) {
                log('fff' + element.toString());
              });
              return content.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: transactions.length,
                      itemBuilder: (_, index) {
                        return TransactionList(
                            onPressed: () {
                              //todo
                              log('sadsad');
                            },
                            data: transactions[index]);
                      })
                  : Center(child: Text(l10n.youDoNotHaveAnyTransaction));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: 5,
                ),
              );
            }
          },
        )),
      ],
    );
  }
}
