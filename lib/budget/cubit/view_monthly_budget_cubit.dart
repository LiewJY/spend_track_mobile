import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/transactionSummary.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/repositories/repositories.dart';

part 'view_monthly_budget_state.dart';

// class ViewMonthlyBudgetCubit extends Cubit<ViewMonthlyBudgetState> {
//   ViewMonthlyBudgetCubit() : super(ViewMonthlyBudgetState.initial());
// }

class ViewMonthlyBudgetCubit extends Cubit<ViewMonthlyBudgetState> {
  // final CategoryRepository categoryRepository;
  final BudgetRepository budgetRepository;
  final TransactionRepository transactionRepository;

  ViewMonthlyBudgetCubit(this.budgetRepository, this.transactionRepository)
      : super(ViewMonthlyBudgetState.initial());

  getMyMonthlyBudgets(yearMonth) async {
    if (state.status == ViewMonthlyBudgetStatus.loading) return;
    emit(state.copyWith(status: ViewMonthlyBudgetStatus.loading));
    List<Budget> budget = [];
    TransactionSummary monthlyTransactionSummary;
    try {
      // budget = await budgetRepository.getMyMonthlyBudgets(yearMonth);
      budget = await budgetRepository.getMyBudgets();
      monthlyTransactionSummary =
          await transactionRepository.getMonthlyTransactionSummary(yearMonth);

      //map (joins) items from both list
      List<Budget> joinedList = [];

      Map<String, Budget> budgetDataMap = {};
      Map<String, SpendingByCategory> spendingByCategoryDataMap = {};
      for (var item in budget) {
        budgetDataMap[item.uid!] = item;
      }
      for (var item in monthlyTransactionSummary.spendingCategoryList!) {
        spendingByCategoryDataMap[item.id!] = item;
      }
      for (var id in {
        ...budgetDataMap.keys,
        ...spendingByCategoryDataMap.keys
      }) {
        var budgetModel = budgetDataMap[id];
        var spendingByCategoryModel = spendingByCategoryDataMap[id];

        var name;

        if (budgetModel?.name != null) {
          name = budgetModel?.name;
        } else {
          name = spendingByCategoryModel?.categoryName;
        }

        var joinedItem = Budget(
          uid: id,
          name: name,
          amount: budgetModel?.amount ?? 0,
          color: budgetModel?.color ?? '0xff20426F',
          amountSpent: spendingByCategoryModel?.amount ?? 0,
        );

        joinedList.add(joinedItem);
      }

      //join both
      joinedList.forEach((element) {
        log('aa  ' + element.toString());
      });

      emit(state.copyWith(
        status: ViewMonthlyBudgetStatus.success,
        success: 'loadedData',
        monthlyBudgetList: joinedList,
        monthlySpendingTotal: monthlyTransactionSummary.totalSpending,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ViewMonthlyBudgetStatus.failure,
        error: e.toString(),
      ));
    }
  }

  // addToMyBudgets({
  //   required Budget budget,
  //   String? documentId,
  // }) async {
  //   if (state.status == ViewMonthlyBudgetStatus.loading) return;
  //   emit(state.copyWith(status: ViewMonthlyBudgetStatus.loading));

  //   try {
  //     await budgetRepository.addToBudgets(budget, documentId);
  //     emit(state.copyWith(
  //       status: ViewMonthlyBudgetStatus.success,
  //       success: 'added',
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: ViewMonthlyBudgetStatus.failure,
  //       error: e.toString(),
  //     ));
  //   }
  // }
}
