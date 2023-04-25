part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequest extends AuthEvent {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);
}

class RegisterRequest extends AuthEvent {
  final String email;
  final String password;

  RegisterRequest(this.email, this.password);
}

//todo implement this
class GoogleLoginRequest extends AuthEvent {}

class LogoutRequest extends AuthEvent {}
