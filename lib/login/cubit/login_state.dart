// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  // final String email;
  // final String password;
  final LoginStatus status;

  const LoginState({
    // required this.email,
    // required this.password,
    required this.status,
  });

  //initializing
  factory LoginState.initial() {
    return const LoginState(
      // email: '',
      // password: '',
      status: LoginStatus.initial,
    );
  }

  @override
  List<Object> get props => [status];

  // List<Object> get props => [email, password, status];

  LoginState copyWith({
    // String? email,
    // String? password,
    LoginStatus? status,
  }) {
    return LoginState(
      // email: email ?? this.email,
      // password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}

//class LoginInitial extends LoginState {}
