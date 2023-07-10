import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/bloc/card_bloc.dart';
import 'package:track/account/card/cubit/available_card_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
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
          l10n.cardAvailable,
        ),
      ),
      body: Padding(
        padding: AppStyle.paddingHorizontal,
        child: RepositoryProvider(
          create: (context) => CardRepository(),
          child: BlocProvider(
            create: (context) =>
                AvailableCardCubit(context.read<CardRepository>()),
            child: BlocListener<AvailableCardCubit, AvailableCardState>(
              listener: (context, state) {
                switch (state.success) {
                  case 'added':
                    if (isDialogOpen) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    AppSnackBar.success(context, l10n.cardAddSuccess);
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
  List<CreditCard> cards = [];

  @override
  initState() {
    super.initState();
    //initial call
    context.read<AvailableCardCubit>().getAvailableCards();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    cards = context
        .select((AvailableCardCubit bloc) => bloc.state.availableCardList);
    return cards.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: cards.length,
            itemBuilder: (_, index) {
              return AddCardsCard(
                title: cards[index].name.toString(),
                subtitle: '${cards[index].cardType}, ${cards[index].bank}',
                buttonPressed: () {
                  context
                      .read<AvailableCardCubit>()
                      .getCardDetails(cards[index].uid.toString());
                  if (!isDialogOpen) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<AvailableCardCubit>(context),
                            child: CardDetailsDialog(
                              dialogTitle: cards[index].name.toString(),
                              data: cards[index],
                            ),
                          );
                        }).then((value) {
                      toggleDialog();
                    });
                    toggleDialog();
                  }
                },
                iconPressed: () {
                  if (!isDialogOpen) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return BlocProvider.value(
                            value: BlocProvider.of<AvailableCardCubit>(context),
                            child: CardDialog(
                              dialogTitle: l10n.addToMyCards,
                              actionName: l10n.addToMyCards,
                              action: 'addToMyCard',
                              data: cards[index],
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
