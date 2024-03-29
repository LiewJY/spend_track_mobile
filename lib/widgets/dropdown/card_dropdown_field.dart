import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';

class CardDropDownField extends StatefulWidget {
  const CardDropDownField({
    super.key,
    required this.onChanged,
    this.value,
  });

  final onChanged;
  final value;

  @override
  State<CardDropDownField> createState() => _CardDropDownFieldState();
}

class _CardDropDownFieldState extends State<CardDropDownField> {
  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(DisplayCardRequested());
  }

//store credit card
  List<CreditCard>? myCards;
  CreditCard? selectedValue;

  List<DropdownMenuItem<CreditCard>> get cardDropdownItems {
    List<DropdownMenuItem<CreditCard>> menuItems = [];
    for (CreditCard element in myCards!) {
      menuItems.add(DropdownMenuItem(
        value: element,
        child: Text(element.customName.toString()),
      ));
    }
    return menuItems;
  }

  CreditCard? selected(desiredUid) {
    log(' df  ' + desiredUid.toString());
    if (desiredUid != null) {
      try {
        return selectedValue = cardDropdownItems
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
    myCards = context.select((CardBloc bloc) => bloc.state.cardList);

    final l10n = context.l10n;
    String? validator(value) {
      if (value != null) {
        return null;
      } else {
        return l10n.pleaseSelectCard;
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField(
          value: selected(widget.value),
          decoration: InputDecoration(
            labelText: l10n.selectCard,
          ),
          items: cardDropdownItems,
          onChanged: widget.onChanged,
          validator: validator,
        ),
        if (myCards!.isEmpty) ...[
          Text(
            l10n.noCardAvailable,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ]
      ],
    );
  }
}
