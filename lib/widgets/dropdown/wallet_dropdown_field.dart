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
    this.value,
  });

  final onChanged;
  final value;

  @override
  State<WalletDropDownField> createState() => _WalletDropDownFieldState();
}

List<DropdownMenuItem> get walletDropdownItems {
  List<DropdownMenuItem> menuItems = [];
  for (Wallet element in myWalltes!) {
    menuItems.add(DropdownMenuItem(
      value: element.toFirestore().toString(),
      child: Text(element.customName.toString()),
    ));
  }
  return menuItems;
}

//store category
List<Wallet>? myWalltes;

class _WalletDropDownFieldState extends State<WalletDropDownField> {
  @override
  void initState() {
    super.initState();
     context.read<WalletBloc>().add(DisplayWalletRequested());
  }

  @override
  Widget build(BuildContext context) {
    //store data of card
    myWalltes = context.select((WalletBloc bloc) => bloc.state.walletList);

    final l10n = context.l10n;
    String? validator(value) {
      if (value != null) {
        return null;
      } else {
        return l10n.pleaseSelectWallet;
      }
    }

    return DropdownButtonFormField(
      value: widget.value,
      decoration: InputDecoration(
        labelText: l10n.selectWallet,
      ),
      items: walletDropdownItems,
      onChanged: widget.onChanged,
      validator: validator,
    );
  }
}
