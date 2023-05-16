import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Wallet name'),
            subtitle: Text('cash / e-wallet'),
            trailing: IconButton(
              onPressed: () => onDelete(),
              icon: Icon(Icons.delete),
            ),
          ),
          Padding(
            padding: AppStyle.cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () => walletCardEdit(),
                  child: Text(l10n.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void walletCardEdit() {
    log("pressed wc");
    //todo
  }

  void onDelete() {
    log('delete');
    //todo
  }
}
