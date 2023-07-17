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
    required this.data,
  });
  final Budget data;
  @override
  List<Object> get props => [data];
}

//todo update

//todo remove