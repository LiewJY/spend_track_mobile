import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/card/cubit/card_cashback_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/widgets/form_field/amount_field.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class EditMyCardDialog extends StatefulWidget {
  const EditMyCardDialog({
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
  State<EditMyCardDialog> createState() => _EditMyCardDialogState();
}

class _EditMyCardDialogState extends State<EditMyCardDialog> {
  final cardForm = GlobalKey<FormState>();

  ///late final String uid;
  final _nameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  //final _cardBudgetController = TextEditingController();

  //for payment reminder
  String reminderDay = '1';
  bool _isReminder = true;
  String? _paymentDay;

  List<Cashback> cashbacks = [];
  @override
  void initState() {
    super.initState();
    context.read<CardCashbackCubit>().getCardDetails(widget.data!.uid!);
    _isReminder = widget.data!.isReminder!;
    //todo payment day
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    cashbacks =
        context.select((CardCashbackCubit bloc) => bloc.state.cardDetailList);
    log(cashbacks.length.toString());
    //populate textfield
    _nameController.text = widget.data!.customName!;
    _cardNumberController.text = widget.data!.lastNumber!;
    //_cardBudgetController.text = widget.data!.budget.toString();

    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: AppStyle.modalPadding,
          child: Form(
            key: cardForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ],
                ),
                AppStyle.sizedBoxSpace,
                NameField(controller: _nameController),
                AppStyle.sizedBoxSpace,
                CardNumberField(
                    controller: _cardNumberController,
                    label: l10n.last4DigitOfCard),
                AppStyle.sizedBoxSpace,
                // AmountField(
                //   controller: _cardBudgetController,
                //   label: l10n.budget,
                // ),
                // AppStyle.sizedBoxSpace,
                SwitchField(
                    label: l10n.paymentReminder,
                    switchState: _isReminder,
                    onChanged: (value) {
                      setState(() {
                        _isReminder = value;
                      });
                    }),
                if (_isReminder) ...[
                  Container(
                    width: double.infinity,
                    child: SegmentedButton(
                      showSelectedIcon: false,
                      selected: {reminderDay},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          reminderDay = newSelection.first;
                        });
                      },
                      segments: [
                        ButtonSegment(
                          value: '1',
                          label: Text(
                            l10n.one,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ButtonSegment(
                          value: '3',
                          label: Text(
                            l10n.three,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ButtonSegment(
                          value: '7',
                          label: Text(
                            l10n.seven,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppStyle.sizedBoxSpace,
                  PaymentDayDropDownField(onChanged: (value) {
                    log(value);
                    setState(() {
                      _paymentDay = value;
                    });
                  })
                ],

                //card details
                AppStyle.sizedBoxSpace,
                Text(
                  l10n.cardDetails,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                BlocBuilder<CardCashbackCubit, CardCashbackState>(
                  builder: (context, state) {
                    if (state.status == CardCashbackStatus.success) {
                      switch (state.success) {
                        case 'cashbackLoaded':
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
                AppStyle.sizedBoxSpace,
                FilledButton(
                  style: AppStyle.fullWidthButton,
                  onPressed: () => save(),
                  child: Text(l10n.save),
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
      ),
    );
  }

  save() {
    if (cardForm.currentState!.validate()) {
      context.read<CardBloc>().add(UpdateCardRequested(
            uid: widget.data!.uid!,
            customName: _nameController.text,
            lastNumber: _cardNumberController.text,
            //budget: double.parse( _cardBudgetController.text),
          ));
    }

    //     context.read<AvailableCardCubit>().addToMyCards(card: widget.data,
    // customName: _nameController.text,
    // lastNumber: _cardNumberController.text);
  }
}
