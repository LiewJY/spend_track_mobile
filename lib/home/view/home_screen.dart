import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track_theme/track_theme.dart';
import 'package:track/home/home.dart';
import 'package:track/transaction/transaction.dart';
import 'package:track/add/add.dart';
import 'package:track/budget/budget.dart';
import 'package:track/account/account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  //for routing
  static Page<void> page() => const MaterialPage<void>(child: HomeScreen());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bottom navigation bar
  //fixme
  int currentPageIndex = 3;

  //repos
  final authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations:  <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home_outlined),
            label: l10n.home,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.transform),
            icon: Icon(Icons.transform_outlined),
            label: l10n.transaction,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add),
            icon: Icon(Icons.add),
            label: l10n.add,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.attach_money),
            icon: Icon(Icons.attach_money_outlined),
            label: l10n.budget,
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: l10n.account,
          ),
        ],
      ),
      body: const <Widget>[
        SafeArea(
            child: Padding(
          padding: AppStyle.paddingHorizontal,
          child: HomeScreenContent(),
        )),
        SafeArea(
            child: TransactionScreenContent()),
        SafeArea(
            child: AddScreenContent()),
        SafeArea(
            child: BudgetScreenContent()),
        SafeArea(
            child: Padding(
          padding: AppStyle.paddingHorizontal,
          child: AccountScreenContent(),
        )),
      ][currentPageIndex],
    );
  }
}
