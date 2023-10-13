import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class AddWalletCard extends StatelessWidget {
  const AddWalletCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPressed,
  });

  final String title;
  final String subtitle;
  final iconPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: IconButton(
              onPressed: iconPressed,
              icon: Icon(Icons.add),
            ),
          ),
          // Padding(
          //   padding: AppStyle.cardPadding,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       FilledButton(
          //         onPressed: () => walletCardEdit(),
          //         child: Text(l10n.edit),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  // void walletCardEdit() {
  //   log("pressed wc");
  //   //todo
  // }

  // void onDelete() {
  //   log('delete');
  //   //todo
  // }
}
