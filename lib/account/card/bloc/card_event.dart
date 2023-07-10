part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}


class DisplayCardRequested extends CardEvent {

  @override
  List<Object> get props => [];
}

class DeleteCardRequested extends CardEvent {
  const DeleteCardRequested({required this.uid});

  final String uid;

  @override
  List<Object> get props => [uid];
}

// class AddCardRequested extends CardEvent {

//   @override
//   List<Object> get props => [];
// }