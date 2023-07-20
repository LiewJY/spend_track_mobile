import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
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
import 'package:track/transaction/bloc/transaction_bloc.dart';
import 'package:track/widgets/form_field/amount_field.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({super.key, this.data, this.isEdit});

  var isEdit;
  //todo need to fix this for edit
  final MyTransaction? data;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

//todo put to util
formatDate(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy').format(dateTime);
}

class _TransactionFormState extends State<TransactionForm> {
  final transactionForm = GlobalKey<FormState>();

  String isWallet = 'wallet';
  CreditCard? _cardSelected;
  String? _cardSelectedId;

  Wallet? _walletSelected;
  String? _walletSelectedId;

  DateTime? _originalYearMonth; //this is used for edit only
  bool isEdit = false; //this is used for edit only

  SpendingCategory? _categorySelected;
  String? _categorySelectedId;
  bool _isCashback = true;
  DateTime? transactionDate = DateTime.now();
  // final TextEditingController _dateInputController;
  TextEditingController _dateInputController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateInputController.text = formatDate(DateTime.now());
    if (widget.isEdit == true) {
      log(widget.data.toString());
      _titleController.text = widget.data!.name.toString();
      _amountController.text = widget.data!.amount!.toStringAsFixed(2);
      _dateInputController.text = formatDate(widget.data!.date!);
      transactionDate = widget.data!.date!;
      _noteController.text = widget.data!.note!;
      _categorySelectedId = widget.data!.categoryId.toString();
      isWallet = widget.data!.isWallet!;
      //??  use either
      _walletSelectedId = widget.data!.fundSourceCustomId.toString();
      _cardSelectedId = widget.data!.fundSourceCustomId.toString();
      _originalYearMonth = widget.data!.date!;
      isEdit = true;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // if (widget.isEdit == true) {

    // }

    return SingleChildScrollView(
      child: Form(
        key: transactionForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppStyle.sizedBoxSpace,
            TransactionTitleField(controller: _titleController),
            AppStyle.sizedBoxSpace,
            AmountField(controller: _amountController, label: l10n.amount),
            AppStyle.sizedBoxSpace,

            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.calendar_today_rounded)),
              controller: _dateInputController,
              readOnly: true,
              onTap: () async {
                DateTime? pick = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2021),
                    lastDate: DateTime.now(),
                    currentDate: transactionDate);
                if (pick != null) {
                  _dateInputController.text = formatDate(pick!);
                  transactionDate = pick;
                }
              },
            ),
            AppStyle.sizedBoxSpace,
            NoteField(controller: _noteController),
            AppStyle.sizedBoxSpace,
            CategoryDropDownField(
                value: _categorySelectedId,
                onChanged: (value) {
                  log(value.toString());
                  setState(() {
                    _categorySelected = value;
                  });
                }),
            AppStyle.sizedBoxSpace,
            Container(
              width: double.infinity,
              child: SegmentedButton(
                selected: {isWallet},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    isWallet = newSelection.first;
                  });
                },
                segments: [
                  ButtonSegment(
                    enabled: !isEdit,
                    value: 'wallet',
                    label: Text(l10n.wallet),
                    icon: Icon(Icons.wallet),
                  ),
                  ButtonSegment(
                    enabled: !isEdit,
                    value: 'card',
                    label: Text(l10n.card),
                    icon: Icon(Icons.credit_card),
                  ),
                ],
              ),
            ),
            AppStyle.sizedBoxSpace,
            if (isWallet == 'wallet') ...[
              WalletDropDownField(
                  value: _walletSelectedId,
                  // onSaved: (value) => setState((

                  // ) => print(value.toString())),

                  //  (value) {
                  //   log('ons ' + value.toString());
                  //   setState(() {
                  //     _walletSelected = value;
                  //   });
                  // },
                  onChanged: (value) {
                    log(value.toString());
                    setState(() {
                      _walletSelected = value;
                    });
                  }),
            ],
            if (isWallet == 'card') ...[
              CardDropDownField(
                  value: _cardSelectedId,
                  onChanged: (value) {
                    log(value.toString());
                    setState(() {
                      _cardSelected = value;
                    });
                  }),
              AppStyle.sizedBoxSpace,
              if (!isEdit) ...[
                SwitchField(
                    label: l10n.isCashbackEligible,
                    switchState: _isCashback,
                    onChanged: (value) {
                      setState(() {
                        _isCashback = value;
                      });
                    }),
              ] else ...[
                Row(
                  children: [
                    Text(
                      l10n.isCashbackEligible,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    //todo place into style file
                    SizedBox(width: 10),
                    Text(
                      _isCashback ? l10n.yes : l10n.no,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                )
              ],
            ],
            AppStyle.sizedBoxSpace,
            //action buttons
            FilledButton(
              style: AppStyle.fullWidthButton,
              onPressed: () {
                action();
                //addTransaction();
              },
              child: Text(widget.isEdit == true
                  ? l10n.saveTransaction
                  : l10n.addTransaction),
            ),
            if (widget.isEdit != true)
              OutlinedButton(
                style: AppStyle.fullWidthButton,
                onPressed: () {
                  //clear();
                },
                child: Text(l10n.clear),
              ),
          ],
        ),
      ),
    );
  }

  double? stringToDouble(value) {
    return double.tryParse(value);
  }

  //action
  action() {
    var storeTransaction;

    if (isWallet == 'wallet') {
      storeTransaction = MyTransaction(
        //uid: widget.isEdit == true ? widget.data?.uid : null,
        name: _titleController.text,
        amount: stringToDouble(_amountController.text),
        date: transactionDate,
        note: _noteController.text,
        categoryId: _categorySelected?.uid,
        category: _categorySelected?.name,
        isWallet: isWallet,
        fundSourceCustomId: _walletSelected?.uid,
        fundSourceCustom: _walletSelected?.customName,
      );

      // log('storeTransaction ' + storeTransaction.toString());
    } else if (isWallet == 'card') {
      // CreditCard card = CreditCard.fromJson(_cardSelected);
      storeTransaction = MyTransaction(
        // uid: widget.isEdit == true ? widget.data?.uid : null,
        name: _titleController.text,
        amount: stringToDouble(_amountController.text),
        date: transactionDate,
        note: _noteController.text,
        categoryId: _categorySelected?.uid,
        category: _categorySelected?.name,
        isWallet: isWallet,
        fundSourceCustomId: _cardSelected?.uid,
        fundSourceCustom: _cardSelected?.customName,
        isCashbackEligible: _isCashback,
      );
    }

    if (transactionForm.currentState!.validate()) {
      log('11111' + transactionDate.toString());
      if (widget.isEdit == true) {
        //? edit
        //todo
        log('storeTransaction uid' + widget.data!.uid.toString());

        log('storeTransaction final' + storeTransaction.toString());
        log('storeTransaction final' + storeTransaction.toString());
        context.read<TransactionBloc>().add(UpdateTransactionRequested(
            data: storeTransaction,
            uid: widget.data!.uid.toString(),
            originalYearMonth: _originalYearMonth!));
      } else {
        //? add
        context.read<AddTransactionCubit>().addTransaction(storeTransaction);
      }
    }
  }

  // clear() {
  //   //general
  //   _titleController.clear();
  //   //_dateInputController.text = formatDate(DateTime.now());
  //   _noteController.clear();
  //   _categorySelected = null;

  //   //wallet

  //   //card
  //   _isCashback = true;
  // }
}
