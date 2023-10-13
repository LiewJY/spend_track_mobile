import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';
import 'package:track/widgets/widgets.dart';

class AddCardModal extends StatelessWidget {
  const AddCardModal({super.key, this.actionLeft,});

  final actionLeft;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      //this padding is for the keyboard
      padding: AppStyle.modalPadding,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SizedBox(
          height: 200,
          child: GridView.count(
            childAspectRatio: 16/9,
            crossAxisCount: 2,
            children: [
              CardButton(
                  onTap: actionLeft,
                  color: 'primary',
                  text: l10n.addCard,
                  icon: Icons.credit_card),
            ],
          ),

        ),
      ),
    );
  }
}


