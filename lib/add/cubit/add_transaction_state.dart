part of 'add_transaction_cubit.dart';

enum AddTransactionStatus { initial, loading, success, failure }

class AddTransactionState extends Equatable {
  final AddTransactionStatus status;
  final String error;
  final String success;

  const AddTransactionState({
    required this.status,
    required this.error,
    required this.success,
  });

  //initializing
  factory AddTransactionState.initial() {
    return const AddTransactionState(
      status: AddTransactionStatus.initial,
      error: '',
      success: '',
    );
  }

  @override
  List<Object> get props => [status, error];

  AddTransactionState copyWith({
    AddTransactionStatus? status,
    String? error,
    String? success,
  }) {
    return AddTransactionState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}
