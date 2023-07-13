import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/account/wallet/cubit/available_wallet_cubit.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/repositories/repos/category/category_repository.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class AvailableBudgetListScreen extends StatefulWidget {
  const AvailableBudgetListScreen({super.key});

  @override
  State<AvailableBudgetListScreen> createState() =>
      _AvailableBudgetListScreenState();
}

class _AvailableBudgetListScreenState extends State<AvailableBudgetListScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.close),
        //     onPressed: () => log('ffff'),
        //   ),
        // ],
        title: Text(
          l10n.budgetCategoryAvailable,
        ),
      ),
      body: Padding(
        padding: AppStyle.paddingHorizontal,
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => CategoryRepository(),
            ),
            RepositoryProvider(
              create: (context) => BudgetRepository(),
            ),
          ],
          child: BlocProvider(
            create: (context) => AvailableBudgetCubit(
                context.read<CategoryRepository>(),
                context.read<BudgetRepository>()),
            child: BlocListener<AvailableBudgetCubit, AvailableBudgetState>(
              listener: (context, state) {
                switch (state.success) {
                  case 'added':
                    //todo
                    if (isDialogOpen) {
                      Navigator.of(context, rootNavigator: true).pop();
                    }
                    AppSnackBar.success(context, l10n.budgetAddSuccess);
                    break;
                  default:
                }
              },
              child: AvailableBudgetCategoryList(),
            ),
          ),
        ),
      ),
    );
  }
}

//for dialog
bool isDialogOpen = false;
void toggleDialog() {
  isDialogOpen = !isDialogOpen;
}

class AvailableBudgetCategoryList extends StatefulWidget {
  const AvailableBudgetCategoryList({super.key});

  @override
  State<AvailableBudgetCategoryList> createState() => _AvailableCardListState();
}

class _AvailableCardListState extends State<AvailableBudgetCategoryList> {
  List<SpendingCategory> categories = [];

  @override
  initState() {
    super.initState();
    //initial call
    context.read<AvailableBudgetCubit>().getAvailableBudgetCategory();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    categories = context.select((AvailableBudgetCubit bloc) =>
        bloc.state.availableSpendingCategoryList);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (_, index) {
          return CategoryList(
            data: categories[index],
            onPressed: () {
              // log('pressed');

              showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: BlocProvider.of<AvailableBudgetCubit>(context),
                      child: BudgetDialog(
                        dialogTitle: l10n.addToMyBudget,
                        actionName: l10n.addToMyBudget,
                        action: 'addToMyBudget',
                        data: categories[index],
                      ),
                    );
                  }).then((value) {
                toggleDialog();
              });
              toggleDialog();
              // }
            },
          );
        });
    // wallets = context
    //     .select((AvailableWalletCubit bloc) => bloc.state.availableWalletList);
    // return wallets.isNotEmpty
    //     ? ListView.builder(
    //         shrinkWrap: true,
    //         itemCount: 1,
    //         itemBuilder: (_, index) {
    //           return CategoryList();

    //           // return AddWalletCard(
    //           //   title: wallets[index].name.toString(),
    //           //   subtitle: wallets[index].description.toString(),
    //           //   iconPressed: () {
    //           //     if (!isDialogOpen) {
    //           //       showDialog(
    //           //           context: context,
    //           //           builder: (_) {
    //           //             return BlocProvider.value(
    //           //               value: BlocProvider.of<AvailableWalletCubit>(context),
    //           //               child: WalletDialog(
    //           //                 dialogTitle: l10n.addToMyWallets,
    //           //                 actionName: l10n.addToMyWallets,
    //           //                 action: 'addToMyWallet',
    //           //                 data: wallets[index],
    //           //               ),
    //           //             );
    //           //           }).then((value) {
    //           //         toggleDialog();
    //           //       });
    //           //       toggleDialog();
    //           //     }
    //           //   },
    //           //   // content: cards[index].bank.toString(),
    //           // );
    //         })
    //     : Center(
    //         child: CircularProgressIndicator(
    //           value: 5,
    //         ),
    //       );
  }
}
