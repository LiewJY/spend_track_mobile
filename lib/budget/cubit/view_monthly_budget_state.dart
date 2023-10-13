part of 'view_monthly_budget_cubit.dart';

enum ViewMonthlyBudgetStatus { initial, loading, success, failure }

class ViewMonthlyBudgetState extends Equatable {
  final ViewMonthlyBudgetStatus status;
  final String error;
  final String success;
  final List<Budget> monthlyBudgetList;
  final double monthlySpendingTotal;

  const ViewMonthlyBudgetState({
    required this.status,
    required this.error,
    required this.success,
    required this.monthlyBudgetList,
    required this.monthlySpendingTotal,
  });

  //initializing
  factory ViewMonthlyBudgetState.initial() {
    return const ViewMonthlyBudgetState(
        status: ViewMonthlyBudgetStatus.initial,
        error: '',
        success: '',
        monthlyBudgetList: [],
        monthlySpendingTotal: 0,);
  }

  @override
  List<Object> get props => [
        status,
        error,
        success,
        monthlyBudgetList,
        monthlySpendingTotal,
      ];

  ViewMonthlyBudgetState copyWith({
    ViewMonthlyBudgetStatus? status,
    String? error,
    String? success,
    List<Budget>? monthlyBudgetList,
    double? monthlySpendingTotal,
  }) {
    return ViewMonthlyBudgetState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      monthlyBudgetList: monthlyBudgetList ?? this.monthlyBudgetList,
      monthlySpendingTotal: monthlySpendingTotal ?? this.monthlySpendingTotal,
    );
  }
}
