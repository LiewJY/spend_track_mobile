part of 'budget_bloc.dart';

enum BudgetStatus { initial, loading, success, failure }

class BudgetState extends Equatable {
  final BudgetStatus status;
  final String error;
  final String success;
  final List<Budget> budgetList;

  const BudgetState({
    required this.status,
    required this.error,
    required this.success,
    required this.budgetList,
  });

  //initializing
  factory BudgetState.initial() {
    return const BudgetState(
      status: BudgetStatus.initial,
      error: '',
      success: '',
      budgetList: [],
    );
  }

  @override
  List<Object> get props => [status, error, success];

  BudgetState copyWith({
    BudgetStatus? status,
    String? error,
    String? success,
    List<Budget>? budgetList,
  }) {
    return BudgetState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      budgetList: budgetList ?? this.budgetList,
    );
  }
}
