import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/app/repo/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository authRepository;

  AppBloc({required this.authRepository}) : super(Unauthenticated()) {
    //login
    on<LoginRequest>((event, emit) async {
      try {
        await authRepository.login(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError());
        emit(Unauthenticated());
      }
    });
  }
}
