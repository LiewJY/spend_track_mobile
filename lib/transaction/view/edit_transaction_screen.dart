import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/add/add.dart';
import 'package:track/add/bloc/category_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key, required this.data});

  final MyTransaction data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    //repos
    final cardRepository = CardRepository();
    final walletRepository = WalletRepository();
    final categoryRepository = CategoryRepository();
    final transactionRepository = TransactionRepository();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.editTransaction,
        ),
      ),
      body: MultiBlocProvider(
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
            create: (context) =>
                TransactionBloc(transactionRepository: transactionRepository),
          ),
        ],
        child: BlocListener<TransactionBloc, TransactionState>(
          listener: (context, state) {
            if (state.status == TransactionStatus.success) {
              switch (state.success) {
                case 'updated':
                  AppSnackBar.success(context, l10n.transactionUpdateSuccess);
                  Navigator.of(context).pop();
                  break;
              }
            }
          },
          child: Padding(
            padding: AppStyle.paddingHorizontal,
            child: TransactionForm(
              isEdit: true,
              data: data,
            ),
          ),
        ),
      ),
    );
  }
}
