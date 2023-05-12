import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/utils/constant.dart';

class AccountScreenContent extends StatelessWidget {
  const AccountScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    //for auth logout
    final user = context.select((AppBloc bloc) => bloc.state.user);

    bool isBottomSheetOpen = false;

    void toggleBottomSheet() {
      isBottomSheetOpen = !isBottomSheetOpen;
    }

    return BlocListener<ManageAccountBloc, ManageAccountState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state.status == ManageAccountStatus.failure) {
          log('fail');
          //todo
        }
        if (state.status == ManageAccountStatus.success) {
          if (isBottomSheetOpen) {
            Navigator.pop(context);
            //todo add success message
          }
        }
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            //todo add image here
            //leading: NetworkImage(user),
            leading: Icon(Icons.circle),
            title: Text(
              user.name ?? l10n.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Text(
            l10n.myAccount,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListTile(
            title: Text(
              l10n.editName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              if (!isBottomSheetOpen) {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return UpdateNameModal();
                    }).then((value) {
                  toggleBottomSheet();
                });
                toggleBottomSheet();
              }
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Text(
              l10n.changeEmail,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => changeEmail(),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Text(
              l10n.changePassword,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => changePassword(),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          Divider(),
          Text(
            l10n.myWallet,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListTile(
            title: Text(
              l10n.manageWallet,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => manageWallet(),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Text(
              l10n.manageCard,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => manageCard(),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Text(
              l10n.manageCategory,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => manageCategory(),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          Constant.sizedBoxSpace,
          FilledButton(
            style: Constant.fullWidthButton,
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }

  manageCategory() {}

  manageCard() {}

  manageWallet() {}

  changePassword() {}

  changeEmail() {}

}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
