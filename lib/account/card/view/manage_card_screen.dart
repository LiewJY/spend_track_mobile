import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/account/account.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';

class ManageCardScreen extends StatelessWidget {
  const ManageCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isBottomSheetOpen = false;

    void toggleBottomSheet() {
      isBottomSheetOpen = !isBottomSheetOpen;
    }

    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.myCards,
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (!isBottomSheetOpen) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        //todo
                        

                        return UpdateNameModal();
                      }).then((value) {
                    toggleBottomSheet();
                  });
                  toggleBottomSheet();
                }
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: AppStyle.paddingHorizontal,
        child: Column(
          children: [
            // Row(children: [
            // Text(
            //   l10n.myCards,
            //   style: Theme.of(context).textTheme.headlineSmall,
            //   textAlign: TextAlign.left,
            // ),
            // ],),

            //search
            //todo
            //inifinity scroll list
          ],
        ),
      )),
    );
  }
}

class CardInfinityList extends StatefulWidget {
  const CardInfinityList({super.key});

  @override
  State<CardInfinityList> createState() => _CardInfinityListState();
}

class _CardInfinityListState extends State<CardInfinityList> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
