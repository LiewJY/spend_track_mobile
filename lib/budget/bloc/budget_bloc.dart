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
    on<UpdateBudgetRequested>(_onUpdateBudgetRequested);
    on<DeleteBudgetRequested>(_onDeleteBudgetRequested);
  }
  _onUpdateBudgetRequested(
    UpdateBudgetRequested event,
    Emitter emit,
  ) {
    if (state.status == BudgetStatus.loading) return;
    emit(state.copyWith(status: BudgetStatus.loading));
    try {
      budgetRepository.updateBudget(
          uid: event.uid, amount: event.amount);
      emit(state.copyWith(
        status: BudgetStatus.success,
        success: 'updated',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDeleteBudgetRequested(
    DeleteBudgetRequested event,
    Emitter emit,
  ) {
    if (state.status == BudgetStatus.loading) return;
    emit(state.copyWith(status: BudgetStatus.loading));
    try {
      budgetRepository.deleteBudget(event.uid);
      emit(state.copyWith(
        status: BudgetStatus.success,
        success: 'deleted',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BudgetStatus.failure,
        error: e.toString(),
      ));
    }
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
