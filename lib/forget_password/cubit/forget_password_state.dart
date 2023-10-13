part of 'forget_password_cubit.dart';

enum ForgetPasswordStatus { initial, loading, success, failure }

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStatus status;
  final String error;
  final String success;

  const ForgetPasswordState({
    required this.status,
    required this.error,
    required this.success,
  });

  //initializing
  factory ForgetPasswordState.initial() {
    return const ForgetPasswordState(
      status: ForgetPasswordStatus.initial,
      error: '',
      success: '',
    );
  }

  @override
  List<Object> get props => [status, error];

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? error,
    String? success,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }
}
