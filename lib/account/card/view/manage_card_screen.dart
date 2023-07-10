import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:track/account/account.dart';
import 'package:track/account/card/view/card_list_screen.dart';
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

    bool isDialogOpen = false;

    void toggleDialogSheet() {
      isDialogOpen = !isDialogOpen;
    }

    //dialog
    dialog() {
      if (!isDialogOpen) {
        showDialog(
            context: context,
            // isScrollControlled: true,
            useSafeArea: true,
            builder: (BuildContext context) {
              //todo
              return Dialog.fullscreen(
                child: Text('ff'),
              );

              // return AddCardModal(
              //   actionLeft: () {
              //     //close bottom sheet then open list
              //     if (isBottomSheetOpen) {
              //       Navigator.pop(context);
              //     }

              //     // Navigator.of(context).push(MaterialPageRoute(
              //     //     builder: (context) =>  CardListDialog()));
              //   },
              // );
            }).then((value) {
          toggleDialogSheet();
        });
        toggleDialogSheet();
      }
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

                        return AddCardModal(
                          actionLeft: () {
                            //close bottom sheet then open list
                            if (isBottomSheetOpen) {
                              Navigator.pop(context);
                            }
                           // dialog();

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>  CardListScreen()));
                          },
                        );
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

            // AvailableCardsList()
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

