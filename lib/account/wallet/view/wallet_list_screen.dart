import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/wallet/cubit/available_wallet_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class WalletListScreen extends StatefulWidget {
  const WalletListScreen({super.key});

  @override
  State<WalletListScreen> createState() => _WalletListScreenState();
}

class _WalletListScreenState extends State<WalletListScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.close),
        //     onPressed: () => log('ffff'),
        //   ),
        // ],
        title: Text(
          l10n.walletAvailable,
        ),
      ),
      body: Padding(
        padding: AppStyle.paddingHorizontal,
        child: RepositoryProvider(
          create: (context) => WalletRepository(),
          child: BlocProvider(
            create: (context) =>
                AvailableWalletCubit(context.read<WalletRepository>()),
            child: BlocListener<AvailableWalletCubit, AvailableWalletState>(
              listener: (context, state) {
                switch (state.success) {
                  case 'added':
                    if (isDialogOpen) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    AppSnackBar.success(context, l10n.walletAddSuccess);
                    break;
                  default:
                }
              },
              child: AvailableCardsList(),
            ),
          ),
        ),
      ),
    );
  }
}

//for dialog
bool isDialogOpen = false;
void toggleDialog() {
  isDialogOpen = !isDialogOpen;
}

class AvailableCardsList extends StatefulWidget {
  const AvailableCardsList({super.key});

  @override
  State<AvailableCardsList> createState() => _AvailableCardListState();
}

class _AvailableCardListState extends State<AvailableCardsList> {
  List<Wallet> wallets = [];

  @override
  initState() {
    super.initState();
    //initial call
    context.read<AvailableWalletCubit>().getAvailableWallets();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    wallets = context
        .select((AvailableWalletCubit bloc) => bloc.state.availableWalletList);
    return wallets.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: wallets.length,
            itemBuilder: (_, index) {




              return AddWalletCard(
                title: wallets[index].name.toString(),
                subtitle: wallets[index].description.toString(),
                iconPressed: () {
                  if (!isDialogOpen) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<AvailableWalletCubit>(context),
                            child: WalletDialog(
                              dialogTitle: l10n.addToMyWallets,
                              actionName: l10n.addToMyWallets,
                              action: 'addToMyWallet',
                              data: wallets[index],
                            ),
                          );
                        }).then((value) {
                      toggleDialog();
                    });
                    toggleDialog();
                  }
                },
                // content: cards[index].bank.toString(),
              );
            })
        : Center(
            child: CircularProgressIndicator(
              value: 5,
            ),
          );
  }
}
