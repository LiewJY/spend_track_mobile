import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/repos/budget/budget_repository.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
    final BudgetRepository budgetRepository;

  BudgetBloc({required this.budgetRepository}) : super(BudgetState.initial()) {
    on<DisplayBudgetRequested>(_onDisplayBudgetRequested);
    // on<UpdateWalletRequested>(_onUpdateWalletRequested);
    //  on<DeleteWalletRequested>(_onDeleteWaletRequested);
  }

   _onDisplayBudgetRequested(
    DisplayBudgetRequested event,
    Emitter emit,
  ) async {
    if (state.status == BudgetStatus.loading) return;
    emit(state.copyWith(status: BudgetStatus.loading));
    try {
      List<Budget> budgetList = await budgetRepository.getMyBudgets();
      emit(state.copyWith(
        status: BudgetStatus.success,
        success: 'loadedData',
        budgetList: budgetList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
