part of 'app_bloc.dart';

abstract class AppState extends Equatable {
 // const AppState();

  @override
  List<Object> get props => [];
}

class Loading extends AppState {

}

class Authenticated extends AppState {}

class Unauthenticated extends AppState {}

///class AppInitial extends AppState {}
