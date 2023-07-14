part of 'transaction_bloc.dart';

enum TransactionStatus { initial, loading, success, failure }

class TransactionState extends Equatable {
  final TransactionStatus status;
  final String error;
  final String success;
  final List<MyTransaction> transactionList;
  // final List<String> rangeList;

  const TransactionState({
    required this.status,
    required this.error,
    required this.success,
    required this.transactionList,
    // required this.rangeList,
  });

  //initializing
  factory TransactionState.initial() {
    return const TransactionState(
      status: TransactionStatus.initial,
      error: '',
      success: '',
      transactionList: [],
      // rangeList: [],
    );
  }

  @override
  List<Object> get props => [status, error, success];

  TransactionState copyWith({
    TransactionStatus? status,
    String? error,
    String? success,
    List<MyTransaction>? transactionList,
    // List<String>? rangeList,
  }) {
    return TransactionState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      transactionList: transactionList ?? this.transactionList,
      // rangeList: rangeList ?? this.rangeList,
    );
  }
}
