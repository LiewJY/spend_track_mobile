import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/account/wallet/wallet.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track/widgets/widgets.dart';
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
    context.read<WalletBloc>().add(DisplayWalletRequested());

    super.initState();
    //initial call
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
      body: BlocListener<WalletBloc, WalletState>(
        listener: (context, state) {
          if (state.status == WalletStatus.failure) {
            switch (state.error) {
              case 'cannotRetrieveData':
                AppSnackBar.error(context, l10n.cannotRetrieveData);
                break;
            }
          }
          if (state.status == WalletStatus.success) {
            switch (state.success) {
              case 'updated':
                if (isDialogOpen) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                AppSnackBar.success(context, l10n.walletUpdateSuccess);
                refresh();
                break;
              case 'deleted':
                AppSnackBar.success(context, l10n.walletDeleteSuccess);
                refresh();
                break;
              case 'loadedData':
                //reload the data table when data is loaded
                setState(() {});
                break;
            }
          }
        },
        child: SafeArea(
            child: Padding(
                padding: AppStyle.paddingHorizontal,
                child: BlocBuilder<WalletBloc, WalletState>(
                  builder: (context, state) {
                    if (state.status == WalletStatus.success &&
                        state.success == 'loadedData') {
                      return wallets.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: wallets.length,
                              itemBuilder: (_, index) {
                                return WalletsCard(
                                  data: wallets[index],
                                  edit: () {
                                    if (!isDialogOpen) {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return RepositoryProvider(
                                              create: (context) =>
                                                  WalletRepository(),
                                              child: MultiBlocProvider(
                                                providers: [
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        WalletBloc>(context),
                                                  ),
                                                ],
                                                child: EditMyWalletDialog(
                                                  data: wallets[index],
                                                  dialogTitle: l10n.editCard,
                                                ),
                                              ),
                                            );
                                          }).then((value) {
                                        toggleDialog();
                                      });
                                      toggleDialog();
                                    }
                                  },
                                  delete: () {
                                    context.read<WalletBloc>().add(
                                        DeleteWalletRequested(
                                            uid:
                                                wallets[index].uid.toString()));
                                  },
                                );
                              })
                          : Center(child: Text(l10n.youDoNotHaveAnyCard));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: 5,
                        ),
                      );
                    }
                  },
                ))),
      ),
    );
  }
}
