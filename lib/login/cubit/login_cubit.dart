import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(LoginState.initial());

  // void emailChanged(String value) {
  //   log("email changed to $value");
  //   state.copyWith(email: value, status: LoginStatus.initial);
  // }

  // void passwordChanged(String value) {
  //   state.copyWith(email: value, status: LoginStatus.initial);
  // }

  Future<void> loginWithCredentials(
      {required String email, required String password}) async {
    //log("ddd ${state.email.toString()}");
    if (state.status == LoginStatus.loading) return;
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      //fixme
      await authRepository.loginWithCredentials(
          email: email, password: password);
                emit(state.copyWith(
        status: LoginStatus.success,
      ));
          try{
                 // await authRepository.aa();

      // emit(state.copyWith(
      //   status: LoginStatus.success,
      // ));
          } catch(_) {

          }

    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        error: e.toString(),
      ));
      log(" eed   ${e.toString()}");
      //throw e;
    }
  }
}
