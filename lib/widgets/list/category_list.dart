import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/widgets/widgets.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key, required this.onPressed, required this.data});

  final onPressed;
  final SpendingCategory data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListTile(
      title: Text(data.name!),
      // onTap: () {
      //   log('pressed');
      // },
      subtitle: Text(data.description!),
      trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.add)),
    );
  }
}

//for dialog
bool isDialogOpen = false;
void toggleDialog() {
  isDialogOpen = !isDialogOpen;
}
