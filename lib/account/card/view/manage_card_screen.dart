import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/account/card/cubit/card_cashback_cubit.dart';
import 'package:track/account/card/view/card_list_screen.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class ManageCardScreen extends StatefulWidget {
  const ManageCardScreen({super.key});

  @override
  State<ManageCardScreen> createState() => _ManageCardScreenState();
}

class _ManageCardScreenState extends State<ManageCardScreen> {
  List<CreditCard> cards = [];
  @override
  initState() {
    super.initState();
    //initial call
    context.read<CardBloc>().add(DisplayCardRequested());
  }

  reload() {
    context.read<CardBloc>().add(DisplayCardRequested());
  }

  @override
  Widget build(BuildContext context) {
    cards = context.select((CardBloc bloc) => bloc.state.cardList);
    bool isBottomSheetOpen = false;
    final cardRepository = CardRepository();

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
      context.read<CardBloc>().add(DisplayCardRequested());
    }

    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.myCards,
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (!isBottomSheetOpen) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return AddCardModal(
                          actionLeft: () {
                            //close bottom sheet then open list
                            if (isBottomSheetOpen) {
                              Navigator.pop(context);
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CardListScreen()));
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
      body: BlocListener<CardBloc, CardState>(
        listener: (context, state) {
          if (state.status == CardStatus.failure) {
            switch (state.error) {
              case 'cannotRetrieveData':
                AppSnackBar.error(context, l10n.cannotRetrieveData);
                break;
            }
          }
          if (state.status == CardStatus.success) {
            switch (state.success) {
              case 'updated':
                if (isDialogOpen) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                AppSnackBar.success(context, l10n.cardUpdateSuccess);
                refresh();
                break;
              case 'deleted':
                AppSnackBar.success(context, l10n.cardDeleteSuccess);
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
                child: cards.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: cards.length,
                        itemBuilder: (_, index) {
                          return CardsCard(
                            data: cards[index],
                            edit: () {
                              if (!isDialogOpen) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return RepositoryProvider(
                                        create: (context) => CardRepository(),
                                        child: MultiBlocProvider(
                                          providers: [
                                            BlocProvider(
                                              create: (context) =>
                                                  CardCashbackCubit(context
                                                      .read<CardRepository>()),
                                            ),
                                            BlocProvider.value(
                                              value: BlocProvider.of<CardBloc>(
                                                  context),
                                            ),
                                          ],
                                          child: EditMyCardDialog(
                                            data: cards[index],
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
                              context.read<CardBloc>().add(DeleteCardRequested(
                                  uid: cards[index].uid.toString()));
                            },
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(
                          value: 5,
                        ),
                      ))),
      ),
    );
  }
}
