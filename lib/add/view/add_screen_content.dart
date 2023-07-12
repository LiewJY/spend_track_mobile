import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:track/account/card/card.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/category/category_repository.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/transaction/bloc/category_bloc.dart';
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
        ],
        child: TransactionForm(),
      ),
    );
  }
}

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  String fundSource = 'wallet';
  String? _cardSelected;
  String? _walletSelected;
  String? _categorySelected;
  bool _isCashback = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    formatDate(DateTime dateTime) {
      return DateFormat('dd-MM-yyyy').format(dateTime);
    }

    // final TextEditingController _dateInputController;
    TextEditingController _dateInputController = TextEditingController();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _noteController = TextEditingController();

    _dateInputController.text = formatDate(DateTime.now());
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.addTransaction,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.left,
            ),
            AppStyle.sizedBoxSpace,
            TransactionTitleField(controller: _titleController),
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
                    currentDate: DateTime.now());
                if (pick != null) {
                  _dateInputController.text = formatDate(pick!);
                }
              },
            ),
            AppStyle.sizedBoxSpace,
            NoteField(controller: _noteController),
            AppStyle.sizedBoxSpace,
            CategoryDropDownField(onChanged: (value) {
              log(value);
              setState(() {
                _categorySelected = value;
              });
            }),
            AppStyle.sizedBoxSpace,
            Container(
              width: double.infinity,
              child: SegmentedButton(
                selected: {fundSource},
                onSelectionChanged: (newSelection) {
                  setState(() {
                    fundSource = newSelection.first;
                  });
                },
                segments: [
                  ButtonSegment(
                    value: 'wallet',
                    label: Text(l10n.wallet),
                    icon: Icon(Icons.wallet),
                  ),
                  ButtonSegment(
                    value: 'card',
                    label: Text(l10n.card),
                    icon: Icon(Icons.credit_card),
                  ),
                ],
              ),
            ),
            AppStyle.sizedBoxSpace,
            if (fundSource == 'wallet') ...[
              WalletDropDownField(onChanged: (value) {
                log(value);
                setState(() {
                  _walletSelected = value;
                });
              }),
            ],
            if (fundSource == 'card') ...[
              CardDropDownField(onChanged: (value) {
                log(value);
                setState(() {
                  _cardSelected = value;
                });
              }),
              AppStyle.sizedBoxSpace,
              SwitchField(
                  label: l10n.isCashbackEligible,
                  switchState: _isCashback,
                  onChanged: (value) {
                    setState(() {
                      _isCashback = value;
                    });
                  }),
            ],
            AppStyle.sizedBoxSpace,
            //action buttons
            FilledButton(
              style: AppStyle.fullWidthButton,
              onPressed: () {
                log('11111');
              },
              child: Text(l10n.addTransaction),
            ),
            OutlinedButton(
              style: AppStyle.fullWidthButton,
              onPressed: () {
                log('22222');
              },
              child: Text(l10n.clear),
            ),
          ],
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