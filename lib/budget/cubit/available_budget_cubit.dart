import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';
import 'package:track/repositories/repos/category/category_repository.dart';

part 'available_budget_state.dart';

class AvailableBudgetCubit extends Cubit<AvailableBudgetState> {
  final CategoryRepository categoryRepository;
  final BudgetRepository budgetRepository;

  AvailableBudgetCubit(this.categoryRepository, this.budgetRepository)
      : super(AvailableBudgetState.initial());

  getAvailableBudgetCategory() async {
    if (state.status == AvailableBudgetStatus.loading) return;
    emit(state.copyWith(status: AvailableBudgetStatus.loading));
    List<SpendingCategory> categories = [];

    try {
      categories = await categoryRepository.getCategories();
      emit(state.copyWith(
        status: AvailableBudgetStatus.success,
        success: 'loadedData',
        availableSpendingCategoryList: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AvailableBudgetStatus.failure,
        error: e.toString(),
      ));
    }
  }

  addToMyBudgets({
    required Budget budget,
    String? documentId,
  }) async {
    if (state.status == AvailableBudgetStatus.loading) return;
    emit(state.copyWith(status: AvailableBudgetStatus.loading));

    try {
      await budgetRepository.addToBudgets(budget, documentId);
      emit(state.copyWith(
        status: AvailableBudgetStatus.success,
        success: 'added',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AvailableBudgetStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
