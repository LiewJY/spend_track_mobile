import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../app/repo/auth_repository.dart';
//import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  //set unauthenticated as default state
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<AuthEvent>((event, emit) {
      //login request
      on<LoginRequest>((event, emit) async {
        emit(Loading());
        try {
          await authRepository.login(
              email: event.email, password: event.password);
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      });

      //register request
      on<RegisterRequest>((event, emit) async {
        emit(Loading());
        try {
          await authRepository.register(
              email: event.email, password: event.password);
          emit(Authenticated());
        } catch (e) {
          emit(AuthError(e.toString()));
          emit(UnAuthenticated());
        }
      });

      //logout request
      on<LogoutRequest>((event, emit) async {
        emit(Loading());
        await authRepository.signOut();
        emit(UnAuthenticated());
      });
      
      //todo login with google
      //google login request
    });
  }
}
