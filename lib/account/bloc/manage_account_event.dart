part of 'manage_account_bloc.dart';

abstract class ManageAccountEvent extends Equatable {
  const ManageAccountEvent();

  @override
  List<Object> get props => [];
}

class UpdateNameRequested extends ManageAccountEvent {
  const UpdateNameRequested(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

//todo now not in use
class ReAuthRequested extends ManageAccountEvent {
  const ReAuthRequested(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
//todo now not in use
class ChangeEmailRequested extends ManageAccountEvent {
  const ChangeEmailRequested(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ResetPasswordRequested extends ManageAccountEvent {
  const ResetPasswordRequested(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}


