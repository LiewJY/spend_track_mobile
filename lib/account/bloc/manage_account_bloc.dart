import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';

part 'manage_account_event.dart';
part 'manage_account_state.dart';

class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  final AuthRepository authRepository;

  ManageAccountBloc({required this.authRepository})
      : super(ManageAccountState.initial()) {
    on<UpdateNameRequested>((event, emit) async {
      if (state.status == ManageAccountStatus.loading) return;
      emit(state.copyWith(status: ManageAccountStatus.loading));
      try {
        await authRepository.updateName(name: event.name);
        emit(state.copyWith(status: ManageAccountStatus.success));
      } catch (e) {
        emit(state.copyWith(
          status: ManageAccountStatus.failure,
          error: e.toString(),
        ));
      }
    }
    
    );
  }
}
