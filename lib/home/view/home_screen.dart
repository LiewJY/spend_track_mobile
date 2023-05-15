import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/repositories.dart';
import 'package:track/utils/constant.dart';
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
  int currentPageIndex = 4;

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
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home_outlined),
            label: 'home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.transform),
            icon: Icon(Icons.transform_outlined),
            label: 'transaction',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.add),
            icon: Icon(Icons.add),
            label: 'add',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.attach_money),
            icon: Icon(Icons.attach_money_outlined),
            label: 'budget',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: 'account',
          ),
        ],
      ),
      body: const <Widget>[
        SafeArea(
            child: Padding(
          padding: Constant.paddingHorizontal,
          child: HomeScreenContent(),
        )),
        SafeArea(
            child: Padding(
          padding: Constant.paddingHorizontal,
          child: TransactionScreenContent(),
        )),
        SafeArea(
            child: Padding(
          padding: Constant.paddingHorizontal,
          child: AddScreenContent(),
        )),
        SafeArea(
            child: Padding(
          padding: Constant.paddingHorizontal,
          child: BudgetScreenContent(),
        )),
        SafeArea(
            child: Padding(
          padding: Constant.paddingHorizontal,
          child: AccountScreenContent(),
        )),
      ][currentPageIndex],
    );
  }
}
