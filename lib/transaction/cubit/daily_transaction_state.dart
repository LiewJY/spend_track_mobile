part of 'daily_transaction_cubit.dart';

enum DailyTransactionStatus { initial, loading, success, failure }

class DailyTransactionState extends Equatable {
  final DailyTransactionStatus status;
  final String error;
  final String success;
  final List<MyTransaction> transactionList;

  const DailyTransactionState({
    required this.status,
    required this.error,
    required this.success,
     required this.transactionList,
  });

  //initializing
  factory DailyTransactionState.initial() {
    return const DailyTransactionState(
      status: DailyTransactionStatus.initial,
      error: '',
      success: '',
       transactionList: [],
    );
  }

  @override
  List<Object> get props => [status, error, success];

  DailyTransactionState copyWith({
    DailyTransactionStatus? status,
    String? error,
    String? success,
   List<MyTransaction>? transactionList,
  }) {
    return DailyTransactionState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      transactionList: transactionList ?? this.transactionList,
    );
  }
}
