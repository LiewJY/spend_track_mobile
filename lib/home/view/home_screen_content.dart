import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/uitls/constant.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //for auth logout
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Column(
      children: [
        FilledButton(
          style: Constant.fullWidthButton,
          onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
          child: Text(l10n.login),
        ),
        Text(user.email ?? "ssssss")
      ],
    );
  }
  // //action
  // void logout(context) {
  //   context
  // }
}
