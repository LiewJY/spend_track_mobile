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


//todo more
