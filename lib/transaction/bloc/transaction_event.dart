part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

// class DisplayTransactionRangeRequested extends TransactionEvent {
//   @override
//   List<Object> get props => [];
// }

class DisplayTransactionRequested extends TransactionEvent {
  const DisplayTransactionRequested({
    required this.yearMonth,
  });
  final String yearMonth;
  @override
  List<Object> get props => [yearMonth];
}

class DeleteTransactionRequested extends TransactionEvent {
  const DeleteTransactionRequested({
    required this.data,
  });
  final MyTransaction data;
  @override
  List<Object> get props => [data];
}

class UpdateTransactionRequested extends TransactionEvent {
  const UpdateTransactionRequested({
    required this.data,
    required this.uid,
    required this.originalYearMonth,
  });
  final MyTransaction data;
  final String uid;
  final DateTime originalYearMonth;
  @override
  List<Object> get props => [data, uid];
}
