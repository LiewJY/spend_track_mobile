part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}


class DisplayAllAvailableCardRequested extends CardEvent {

  @override
  List<Object> get props => [];
}

// class AddCardRequested extends CardEvent {

//   @override
//   List<Object> get props => [];
// }