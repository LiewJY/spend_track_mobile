import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/utils/constant.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text('Category name'),
            subtitle: Text('description'),
            trailing: IconButton(
              onPressed: () => onDelete(),
              icon: Icon(Icons.delete),
            ),
          ),
          Padding(
            padding: Constant.cardPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () => categoryCardEdit(),
                  child: Text(l10n.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void categoryCardEdit() {
    log("pressed cat card");
    //todo
  }

  void onDelete() {
    log('delete');
    //todo
  }
}
