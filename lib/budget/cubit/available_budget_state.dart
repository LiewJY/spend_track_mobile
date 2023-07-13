part of 'available_budget_cubit.dart';

enum AvailableBudgetStatus { initial, loading, success, failure }

class AvailableBudgetState extends Equatable {
  final AvailableBudgetStatus status;
  final String error;
  final String success;
  // final bool isMax;

   final List<SpendingCategory> availableSpendingCategoryList;
  // final List<Cashback> cardDetailList;

  const AvailableBudgetState({
    required this.status,
    required this.error,
    required this.success,
    // //fixme not use ismax
    // required this.isMax,
    required this.availableSpendingCategoryList,
    // required this.cardDetailList,
  });

  //initializing
  factory AvailableBudgetState.initial() {
    return const AvailableBudgetState(
      status: AvailableBudgetStatus.initial,
      error: '',
      success: '',
      availableSpendingCategoryList: [],
    );
  }

  @override
  List<Object> get props => [status, error];

  AvailableBudgetState copyWith({
    AvailableBudgetStatus? status,
    String? error,
    String? success,
     List<SpendingCategory>? availableSpendingCategoryList,
  }) {
    return AvailableBudgetState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      availableSpendingCategoryList: availableSpendingCategoryList ?? this.availableSpendingCategoryList,
    );
  }
}

