import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/uitls/constant.dart';

class TransactionScreenContent extends StatelessWidget {
  const TransactionScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo

    return Column(
      children: [
        Text("TransactionScreenContent")
      ],
    );
  }
}
