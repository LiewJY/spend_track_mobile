part of 'transaction_range_cubit.dart';

enum TransactionRangeStatus { initial, loading, success, failure }

class TransactionRangeState extends Equatable {
  final TransactionRangeStatus status;
  final String error;
  final String success;
  final List<String> rangeList;

  const TransactionRangeState({
    required this.status,
    required this.error,
    required this.success,
    required this.rangeList,
  });

  //initializing
  factory TransactionRangeState.initial() {
    return const TransactionRangeState(
      status: TransactionRangeStatus.initial,
      error: '',
      success: '',
      rangeList: [],
    );
  }

  @override
  List<Object> get props => [status, error, success];

  TransactionRangeState copyWith({
    TransactionRangeStatus? status,
    String? error,
    String? success,
    List<String>? rangeList,
  }) {
    return TransactionRangeState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      rangeList: rangeList ?? this.rangeList,
    );
  }
}
