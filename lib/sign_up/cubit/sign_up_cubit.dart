import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit(this.authRepository) : super(SignUpState.initial());

  signUp(
      {required String email,
      required String password,
      required String name}) async {
    if (state.status == SignUpStatus.loading) return;
    emit(state.copyWith(status: SignUpStatus.loading));
    try {
      await authRepository.signUp(email: email, password: password, name: name);
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SignUpStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
