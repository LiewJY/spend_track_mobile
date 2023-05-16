import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track_theme/track_theme.dart';
import 'package:track/widgets/card/wallet_card.dart';
import 'package:track/widgets/widgets.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [Text("HomeScreenContent"),
      WalletCard(),
      CardsCard(),
      CategoryCard(),
      ],
    );
  }
}
