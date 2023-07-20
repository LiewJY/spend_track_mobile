import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repositories.dart';

class WalletDropDownField extends StatefulWidget {
  const WalletDropDownField({
    super.key,
    required this.onChanged,
    //required this.onSaved,

    this.value,
  });

  final onChanged;
  // final onSaved;

  final value;

  @override
  State<WalletDropDownField> createState() => _WalletDropDownFieldState();
}

// List<DropdownMenuItem> get walletDropdownItems {
//   List<DropdownMenuItem> menuItems = [];
//   for (Wallet element in myWalltes!) {
//     menuItems.add(DropdownMenuItem(
//       value: element.toFirestore().toString(),
//       child: Text(element.customName.toString()),
//     ));
//   }
//   return menuItems;
// }

class _WalletDropDownFieldState extends State<WalletDropDownField> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(DisplayWalletRequested());
  }

//store wallets
  List<Wallet>? myWallets;
  Wallet? selectedValue;

  List<DropdownMenuItem<Wallet>> get walletDropdownItems {
    List<DropdownMenuItem<Wallet>> menuItems = [];
    for (Wallet element in myWallets!) {
      menuItems.add(DropdownMenuItem<Wallet>(
        value: element,
        child: Text(element.customName.toString()),
      ));
    }
    return menuItems;
  }

  Wallet? selected(desiredUid) {
    log(' df  ' + desiredUid.toString());
    if (desiredUid != null) {
      try {
        return selectedValue = walletDropdownItems
            .firstWhere(
              (item) => item.value?.uid == desiredUid,
            )
            .value;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //store data of card
    myWallets = context.select((WalletBloc bloc) => bloc.state.walletList);

    final l10n = context.l10n;
    String? validator(value) {
      if (value != null) {
        return null;
      } else {
        return l10n.pleaseSelectWallet;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          value: selected(widget.value),
          decoration: InputDecoration(
            labelText: l10n.selectWallet,
          ),
          items: walletDropdownItems,
          onChanged: widget.onChanged,
          //onSaved: widget.onSaved,
          validator: validator,
        ),
        if (myWallets!.isEmpty) ...[
          Text(l10n.noWalletAvailable,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ]
      ],
    );
  }
}
