import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track_theme/track_theme.dart';

class CardsCard extends StatelessWidget {
  const CardsCard({
    super.key,
    required this.data,
    required this.edit,
    required this.delete,
  });

  final CreditCard data;
  final edit;
  final delete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(data.customName.toString()),
            subtitle: Text('${data.name}, ${data.bank}'),
            trailing: IconButton(
              onPressed: delete,
              icon: Icon(Icons.delete),
            ),
          ),
          Padding(
            //todo add to style
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${data.cardType} **${data.lastNumber}'),
              ],
            ),
          ),
          Padding(
            padding: AppStyle.cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: edit,
                  child: Text(l10n.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
