import 'package:flutter/material.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class ManageCardScreen extends StatelessWidget {
  const ManageCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: AppStyle.paddingHorizontal,
        child: Column(
          children: [
            Text(
              l10n.myCards,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.left,
            ),
            //search
          ],
        ),
      )),
    );
  }
}
