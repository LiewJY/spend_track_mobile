part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class DisplayBudgetRequested extends BudgetEvent {
  //const DisplayBudgetRequested({required this.yearMonth});
//
  //final String yearMonth;

  @override
  List<Object> get props => [];
}

class DeleteBudgetRequested extends BudgetEvent {
  const DeleteBudgetRequested({
    required this.uid,
  });
  final String uid;
  @override
  List<Object> get props => [uid];
}

class UpdateBudgetRequested extends BudgetEvent {
  const UpdateBudgetRequested({
    // required this.data,
    required this.uid,
    required this.amount,
  });
  // final Budget data;
  final String uid;
  final double amount;
  @override
  List<Object> get props => [uid, amount];
}
