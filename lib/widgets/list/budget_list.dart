import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track/budget/cubit/available_budget_cubit.dart';
import 'package:track/l10n/l10n.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/widgets/widgets.dart';

class BudgetList extends StatelessWidget {
  const BudgetList({super.key, required this.onPressed, required this.data});

  final onPressed;
  final Budget data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data.name!),
      subtitle: Text('RM ${data.amount!.toStringAsFixed(2)}'),
      //todo make this into dropdown that allow delete and edit
      trailing: IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.more_vert_rounded)),
    );
  }
}
