part of 'manage_account_bloc.dart';

enum ManageAccountStatus { initial, loading, success, failure }

class ManageAccountState extends Equatable {
  final ManageAccountStatus status;
  final String error;
  final String success;

  const ManageAccountState({
    required this.status,
    required this.error,
    required this.success,
  });

  //initializing
  factory ManageAccountState.initial() {
    return const ManageAccountState(
      status: ManageAccountStatus.initial,
      error: '',
      success: '',
    );
  }

  @override
  List<Object> get props => [status, error];

  ManageAccountState copyWith({
    ManageAccountStatus? status,
    String? error,
    String? success,
  }) {
    return ManageAccountState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}

//class ManageAccountInitial extends ManageAccountState {}
