import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class AddCardsCard extends StatelessWidget {
  const AddCardsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonPressed,
    required this.iconPressed,

    // required this.content,
  });

  final String title;
  final String subtitle;
  final buttonPressed;
  final iconPressed;
  // final String content;

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
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Text(content),
          //     ],
          //   ),
          // ),
          Padding(
            padding: AppStyle.cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: buttonPressed,
                  child: Text(l10n.viewDetails),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void AddCardsCardEdit() {
  //   log("pressed cc");
  //   //todo
  // }

  void onDelete() {
    log('delete');
    //todo
  }
}
