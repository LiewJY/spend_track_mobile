import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/uitls/constant.dart';

class AccountScreenContent extends StatelessWidget {
  const AccountScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo
    //for auth logout
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Column(
      children: [
        FilledButton(
          style: Constant.fullWidthButton,
          onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          child: Text(l10n.logout),
        ),
        Text(user.email ?? "empty"),
        Text(user.name ?? "empty")
      ],
    );
  }
}
