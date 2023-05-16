import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:track/repositories/repos/auth/auth_repository.dart';

part 'manage_account_event.dart';
part 'manage_account_state.dart';

class ManageAccountBloc extends Bloc<ManageAccountEvent, ManageAccountState> {
  final AuthRepository authRepository;

  ManageAccountBloc({required this.authRepository})
      : super(ManageAccountState.initial()) {
    //UpdateNameRequested
    on<UpdateNameRequested>((event, emit) async {
      if (state.status == ManageAccountStatus.loading) return;
      emit(state.copyWith(status: ManageAccountStatus.loading));
      try {
        await authRepository.updateName(name: event.name);
        emit(state.copyWith(
            status: ManageAccountStatus.success, success: 'nameUpdated'));
      } catch (e) {
        emit(state.copyWith(
          status: ManageAccountStatus.failure,
          error: e.toString(),
        ));
      }
    });

    //ReAuthRequested
    //todo in UI, now not in use
    on<ReAuthRequested>((event, emit) async {
      if (state.status == ManageAccountStatus.loading) return;
      emit(state.copyWith(status: ManageAccountStatus.loading));
      try {
        //await authRepository.updateName(name: event.name);
        // await authRepository.toString
        emit(state.copyWith(
            status: ManageAccountStatus.success, success: 'emailChanged'));
      } catch (e) {
        emit(state.copyWith(
          status: ManageAccountStatus.failure,
          error: e.toString(),
        ));
      }
    });

    //ResetPasswordRequested
    on<ResetPasswordRequested>((event, emit) async {
      if (state.status == ManageAccountStatus.loading) return;
      emit(state.copyWith(status: ManageAccountStatus.loading));
      try {
        //await authRepository.updateName(name: event.name);
        await authRepository.sendResetPasswordEmail(email: event.email);
        emit(state.copyWith(
          status: ManageAccountStatus.success,
          success: 'resetPasswordEmailSent',
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ManageAccountStatus.failure,
          error: e.toString(),
        ));
      }
    });
  }
}
