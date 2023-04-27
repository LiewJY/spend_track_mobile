part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  //const AppEvent();

  @override
  List<Object> get props => [];
}

class LoginRequest extends AppEvent {
  final String email;
  final String password;

  LoginRequest(this.email, this.password);
}