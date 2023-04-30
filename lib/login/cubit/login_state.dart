// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  // final String email;
  // final String password;
  final LoginStatus status;
  final String error;

  const LoginState({
    // required this.email,
    // required this.password,
    required this.status,
    required this.error,
  });

  //initializing
  factory LoginState.initial() {
    return const LoginState(
      // email: '',
      // password: '',
      status: LoginStatus.initial,
      error: '',
    );
  }

  @override
  List<Object> get props => [status];

  // List<Object> get props => [email, password, status];

  LoginState copyWith({
    // String? email,
    // String? password,
    LoginStatus? status,
    String ? error,
  }) {
    return LoginState(
      // email: email ?? this.email,
      // password: password ?? this.password,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

//class LoginInitial extends LoginState {}
