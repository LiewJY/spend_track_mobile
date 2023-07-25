import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/home/cubit/home_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track_theme/track_theme.dart';
import 'package:track/widgets/card/wallets_card.dart';
import 'package:track/widgets/widgets.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

//todo put to util
formatDate(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.hi(user.name ?? 'user'),
        ),
      ),
      body: Padding(
        padding: AppStyle.paddingHorizontal,
        child: RepositoryProvider(
          create: (context) => HomeRepository(),
          child: BlocProvider(
            create: (context) => HomeCubit(context.read<HomeRepository>()),
            child: HomeContent(),
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({
    super.key,
  });

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    DateTime now = DateTime.now();

    // Get the current year and month
    int year = now.year;
    // int month = now.month;
    String month = DateFormat.MMM().format(now);
    // String yearMonth = '${year}_$month';

    return RefreshIndicator(
      onRefresh: () {
        return context.read<HomeCubit>().getHomeData();
      },
      child: SingleChildScrollView(
        primary: true,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //todo majpr
            AppStyle.sizedBoxSpace,
            Text(
              l10n.overallSpendingForMonth('$month, $year'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppStyle.sizedBoxSpace,
            BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              double spendingPercent;
              if (state.budget == 0) {
                spendingPercent = 1;
              } else if (state.budget > 0) {
                spendingPercent = state.spending / state.budget;
              } else {
                spendingPercent = 1;
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: spendingPercent,
                    minHeight: 25,
                  ),
                  Text(
                    '${l10n.budget}: RM ${state.budget.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${l10n.totalSpending}: RM ${state.spending.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppStyle.sizedBoxSpace,

                  //todo
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.cashback.length,
                      itemBuilder: (_, index) {
                        CreditCard card = state.cashback[index].card!;
                        List<Cashback> cashback =
                            state.cashback[index].cashback!;
                        log(' ccc' + card.toString());

                        return Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // AppStyle.sizedBoxSpace,
                                ListTile(
                                  title: Text(card.customName.toString()),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${card.name}, ${card.bank}'),
                                      Text(
                                          '${l10n.totalSpending}: RM ${state.budget.toStringAsFixed(2)}'),
                                      Text(
                                          '${l10n.validUntil}: ${formatDate(card.validUntil!)}'),
                                    ],
                                  ),

                                  // trailing: IconButton(
                                  //   onPressed: delete,
                                  //   icon: Icon(Icons.delete),
                                  // ),
                                ),
                                Padding(
                                  padding: AppStyle.paddingHorizontal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: cashback
                                        .map((item) => Container(
                                              width: double.infinity,
                                              child: Card(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(item.category!),
                                                      if (item.isCapped!) ...[
                                                        if (item.cappedAt! -
                                                                item.totalSave! <=
                                                            0) ...[
                                                          Text(
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .error,
                                                              ),
                                                              '${l10n.remaining}: RM ${(item.cappedAt! - item.totalSave!).toStringAsFixed(2)}'),
                                                        ] else ...[
                                                          Text(
                                                              '${l10n.remaining}: RM ${(item.cappedAt! - item.totalSave!).toStringAsFixed(2)}'),
                                                        ]
                                                      ] else ...[
                                                        Text(
                                                            '${l10n.saved}: RM ${(item.totalSave!).toStringAsFixed(2)}'),
                                                      ]

                                                      // if (item.cappedAt !=
                                                      //     null) ...[
                                                      //   Text(
                                                      //       '${l10n.saved}: RM ${(item.totalSave!).toStringAsFixed(2)}'),
                                                      // ],
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                AppStyle.sizedBoxSpace,

                                // Padding(
                                //   padding: AppStyle.paddingHorizontal,
                                //   child: Text(
                                //     card.name,
                                //     style: Theme.of(context).textTheme.titleMedium,
                                //   ),
                                // ),
                              ]),
                        );
                      }),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
