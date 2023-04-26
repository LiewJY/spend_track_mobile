import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/app/repo/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required authRepository}) : super(AppInitial()) {
    on<AppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
