import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/add/add.dart';
import 'package:track/add/bloc/category_bloc.dart';
import 'package:track/add/cubit/add_transaction_cubit.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/category/category_repository.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/widgets/form_field/amount_field.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class AddScreenContent extends StatelessWidget {
  const AddScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    //repos
    final cardRepository = CardRepository();
    final walletRepository = WalletRepository();
    final categoryRepository = CategoryRepository();
    final transactionRepository = TransactionRepository();

    final l10n = context.l10n;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: cardRepository,
        ),
        RepositoryProvider.value(
          value: walletRepository,
        ),
        RepositoryProvider.value(
          value: categoryRepository,
        ),
        RepositoryProvider.value(
          value: transactionRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CardBloc(cardRepository: cardRepository),
          ),
          BlocProvider(
            create: (context) => WalletBloc(walletRepository: walletRepository),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository: categoryRepository),
          ),
          BlocProvider(
            create: (context) => AddTransactionCubit(transactionRepository),
          ),
        ],
        child: BlocListener<AddTransactionCubit, AddTransactionState>(
          listener: (context, state) {
            if (state.status == AddTransactionStatus.failure) {
              AppSnackBar.error(context, l10n.failToAddTransaction);
            }
            if (state.status == AddTransactionStatus.success) {
              switch (state.success) {
                case 'transactionAdded':
                  AppSnackBar.success(context, l10n.transactionAddSuccess);
                  break;
                default:
              }
            }
          },
          child: Scaffold(
              appBar: AppBar(
                title: Text(
                  l10n.addTransaction,
                ),
              ),
              body: Padding(
                padding: AppStyle.paddingHorizontal,
                child: TransactionForm(),
              )),
        ),
      ),
    );
  }
}



// //toggle button
// class CardWalletToggle extends StatefulWidget {
//   const CardWalletToggle({super.key});

//   @override
//   State<CardWalletToggle> createState() => _CardWalletToggleState();
// }
//   String fundSource = 'wallet';

// class _CardWalletToggleState extends State<CardWalletToggle> {
//   @override
//   Widget build(BuildContext context) {
//  final l10n = context.l10n;
//     return

//   }
// }
