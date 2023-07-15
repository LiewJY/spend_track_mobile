part of 'monthly_transaction_summary_cubit.dart';

enum MonthlyTransactionSummaryStatus { initial, loading, success, failure }

class MonthlyTransactionSummaryState extends Equatable {
  final MonthlyTransactionSummaryStatus status;
  final String error;
  final String success;
  final TransactionSummary monthlyTransactionSummary;

  const MonthlyTransactionSummaryState({
    required this.status,
    required this.error,
    required this.success,
    required this.monthlyTransactionSummary,
  });

  //initializing
  factory MonthlyTransactionSummaryState.initial() {
    return const MonthlyTransactionSummaryState(
      status: MonthlyTransactionSummaryStatus.initial,
      error: '',
      success: '',
      monthlyTransactionSummary: TransactionSummary(),
    );
  }

  @override
  List<Object> get props => [status, error, success];

  MonthlyTransactionSummaryState copyWith({
    MonthlyTransactionSummaryStatus? status,
    String? error,
    String? success,
    TransactionSummary? monthlyTransactionSummary,
  }) {
    return MonthlyTransactionSummaryState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      monthlyTransactionSummary: monthlyTransactionSummary ?? this.monthlyTransactionSummary,
    );
  }
}
