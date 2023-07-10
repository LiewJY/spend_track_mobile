import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class CardDetailsDialog extends StatefulWidget {
  const CardDetailsDialog({
    super.key,
    required this.dialogTitle,
    // required this.actionName,
    // required this.action,
    this.data,
  });

  final String dialogTitle;
  // final String actionName;
  // final String action;
  final CreditCard? data;

  @override
  State<CardDetailsDialog> createState() => _CardDetailsDialogState();
}

class _CardDetailsDialogState extends State<CardDetailsDialog> {
  final cardForm = GlobalKey<FormState>();
  late final String uid;
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();

  List<Cashback> cashbacks = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    cashbacks =
        context.select((AvailableCardCubit bloc) => bloc.state.cardDetailList);
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyle.modalPadding,
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dialogTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        '${l10n.bank}: ${widget.data!.bank}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '${l10n.cardType}: ${widget.data!.bank}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                        Text(
                        '${l10n.cashback}: ${widget.data!.isCashback! ? l10n.yes : l10n.no}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  )
                ],
              ),
              BlocBuilder<AvailableCardCubit, AvailableCardState>(
                builder: (context, state) {
                  if (state.status == AvailableCardStatus.success) {
                    switch (state.success) {
                      case 'loadedDetailsData':
                        return Column(
                          children: [
                            for (var item in cashbacks)
                              CashbackReviewCard(element: item),
                          ],
                        );
                      default:
                    }
                  }
                  return Column(
                    children: [
                      for (var item in cashbacks)
                        CashbackReviewCard(element: item),
                    ],
                  );
                },
              ),
              OutlinedButton(
                style: AppStyle.fullWidthButton,
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              AppStyle.sizedBoxSpace,
            ],
          ),
        ),
      ),
    );
  }
}
