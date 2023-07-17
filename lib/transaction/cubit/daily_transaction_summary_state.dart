part of 'daily_transaction_summary_cubit.dart';


enum DailyTransactionSummaryStatus { initial, loading, success, failure }

class DailyTransactionSummaryState extends Equatable {
  final DailyTransactionSummaryStatus status;
  final String error;
  final String success;
  //final TransactionSummary monthlyTransactionSummary;

  const DailyTransactionSummaryState({
    required this.status,
    required this.error,
    required this.success,
    //required this.monthlyTransactionSummary,
  });

  //initializing
  factory DailyTransactionSummaryState.initial() {
    return const DailyTransactionSummaryState(
      status: DailyTransactionSummaryStatus.initial,
      error: '',
      success: '',
     // monthlyTransactionSummary: TransactionSummary(),
    );
  }

  @override
  List<Object> get props => [status, error, success];

  DailyTransactionSummaryState copyWith({
    DailyTransactionSummaryStatus? status,
    String? error,
    String? success,
   // TransactionSummary? monthlyTransactionSummary,
  }) {
    return DailyTransactionSummaryState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      //monthlyTransactionSummary: monthlyTransactionSummary ?? this.monthlyTransactionSummary,
    );
  }
}
