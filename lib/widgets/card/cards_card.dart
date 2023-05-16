import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class CardsCard extends StatelessWidget {
  const CardsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Card name'),
            subtitle: Text('visa **1234'),
            trailing: IconButton(
              onPressed: () => onDelete(),
              icon: Icon(Icons.delete),
            ),
          ),
          Padding(
            padding: AppStyle.cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('bank name'),
              ],
            ),
          ),
          Padding(
            padding: AppStyle.cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () => cardsCardEdit(),
                  child: Text(l10n.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void cardsCardEdit() {
    log("pressed cc");
    //todo
  }

  void onDelete() {
    log('delete');
    //todo
  }
}
