import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/account/wallet/wallet.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track_theme/track_theme.dart';

class ManageWalletScreen extends StatefulWidget {
  const ManageWalletScreen({super.key});

  @override
  State<ManageWalletScreen> createState() => _ManageWalletScreenState();
}

class _ManageWalletScreenState extends State<ManageWalletScreen> {
  List<Wallet> wallets = [];
  @override
  initState() {
    super.initState();
    //initial call
   context.read<WalletBloc>().add(DisplayWalletRequested());
  }

  reload() {
    context.read<WalletBloc>().add(DisplayWalletRequested());
  }

  @override
  Widget build(BuildContext context) {
    wallets = context.select((WalletBloc bloc) => bloc.state.walletList);
    bool isBottomSheetOpen = false;
    final walletRepository = WalletRepository();

    void toggleBottomSheet() {
      isBottomSheetOpen = !isBottomSheetOpen;
    }

    //for dialog
    bool isDialogOpen = false;
    void toggleDialog() {
      isDialogOpen = !isDialogOpen;
    }

    refresh() {
      //call load data function
      context.read<WalletBloc>().add(DisplayWalletRequested());
    }

    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.myWallets,
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (!isBottomSheetOpen) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return AddWalletModal(
                          actionLeft: () {
                            //close bottom sheet then open list
                            if (isBottomSheetOpen) {
                              Navigator.pop(context);
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WalletListScreen()));
                          },
                        );
                      }).then((value) {
                    toggleBottomSheet();
                  });
                  toggleBottomSheet();
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: AppStyle.paddingHorizontal,
        child: Text('fff'),
      )),
    );
  }
}
