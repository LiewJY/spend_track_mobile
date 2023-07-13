import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/app/bloc/app_bloc.dart';
import 'package:track/budget/budget.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/widgets/widgets.dart';
import 'package:track_theme/track_theme.dart';

class BudgetScreenContent extends StatelessWidget {
  const BudgetScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    //todo

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myBudget),
        actions: [
          IconButton(
              onPressed: () {
                //open list
                // Builder(builder: 
                //          Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => AvailableBudgetCategoryList()));
                
                // )
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AvailableBudgetListScreen()),
            );
       
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: AppStyle.paddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //todo graph
            Text(
              l10n.overview,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // Text("BudgetScreenContent"),
            //todo total monthly budget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.totalMonthlyBudget,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'RM${'0.00'}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            //todo list view of all budget categories
            Text(
              l10n.budgetByCategory,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text("LIST GO HERE"),
            //todo list builder
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: 10,
            //       shrinkWrap: true,
            //       itemBuilder: (_, index) {
            //         return CategoryList();
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}
