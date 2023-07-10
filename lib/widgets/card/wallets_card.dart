import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track_theme/track_theme.dart';

class WalletsCard extends StatelessWidget {
  const WalletsCard({
    super.key,
    required this.data,
    required this.edit,
    required this.delete,
  });
  final Wallet data;
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
            subtitle: Text('${data.name}, ${data.description}'),
            trailing: IconButton(
              onPressed: delete,
              icon: Icon(Icons.delete),
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

  // void WalletsCardEdit() {
  //   log("pressed wc");
  //   //todo
  // }

  // void onDelete() {
  //   log('delete');
  //   //todo
  // }
}
