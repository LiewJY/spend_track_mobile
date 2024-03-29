import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/account.dart';
import 'package:track/account/wallet/bloc/wallet_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class AccountScreenContent extends StatelessWidget {
  const AccountScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    //for auth logout
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final categoryRepository = CardRepository();
    final walletRepository = WalletRepository();

    bool isBottomSheetOpen = false;

    void toggleBottomSheet() {
      isBottomSheetOpen = !isBottomSheetOpen;
    }

    return BlocListener<ManageAccountBloc, ManageAccountState>(
      listener: (context, state) {
        if (state.status == ManageAccountStatus.failure) {
          AppSnackBar.error(context, state.error);
        }
        if (state.status == ManageAccountStatus.success) {
          if (isBottomSheetOpen) {
            Navigator.pop(context);
          }
          switch (state.success) {
            case 'nameUpdated':
              AppSnackBar.success(context, l10n.nameChanged);
              break;
            case 'resetPasswordEmailSent':
              AppSnackBar.success(context, l10n.resetPasswordEmailSent);
              break;
            // case 'emailChanged':
            //   AppSnackBar.success(context, l10n.emailChanged);
            //   break;
            default:
          }

          //todo support multi action
          //AppSnackBar.success(context, l10n.nameChanged);
        }
      },
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            //todo add image here
            //leading: NetworkImage(user),
            // leading: Icon(Icons.circle),
            title: Text(
              user.name ?? l10n.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(user.email ?? ''),
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
          //todo
          // ListTile(
          //   title: Text(
          //     l10n.changeEmail,
          //     style: Theme.of(context).textTheme.titleMedium,
          //   ),
          //   onTap: () {
          //     if (!isBottomSheetOpen) {
          //       showModalBottomSheet(
          //           context: context,
          //           isScrollControlled: true,
          //           builder: (BuildContext context) {
          //             return ReAuthModal();
          //           }).then((value) {
          //         toggleBottomSheet();
          //       });
          //       toggleBottomSheet();
          //     }
          //   },
          //   trailing: Icon(Icons.arrow_forward_ios_rounded),
          // ),

          ListTile(
            title: Text(
              l10n.resetPassword,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => context
                .read<ManageAccountBloc>()
                .add(ResetPasswordRequested(user.email.toString())),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          //todo link with google
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
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          WalletBloc(walletRepository: walletRepository),
                      child: ManageWalletScreen(),
                    ))),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            title: Text(
              l10n.manageCard,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          CardBloc(cardRepository: categoryRepository),
                      child: ManageCardScreen(),
                    ))),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          //todo remove 
          // ListTile(
          //   title: Text(
          //     l10n.manageCategory,
          //     style: Theme.of(context).textTheme.titleMedium,
          //   ),
          //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
          //       builder: (context) => ManageCategoryScreen())),
          //   trailing: Icon(Icons.arrow_forward_ios_rounded),
          // ),
          AppStyle.sizedBoxSpace,
          FilledButton(
            style: AppStyle.fullWidthButton,
            onPressed: () => context.read<AppBloc>().add(AppLogoutRequested()),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
