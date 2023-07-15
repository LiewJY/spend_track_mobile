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
