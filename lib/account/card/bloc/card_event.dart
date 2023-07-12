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

class DisplayCardCashbackRequested extends CardEvent {
  const DisplayCardCashbackRequested({
    required this.uid,
  });
  final String uid;

  @override
  List<Object> get props => [uid];
}

class UpdateCardRequested extends CardEvent {
  const UpdateCardRequested({
    required this.uid,
    required this.customName,
    required this.lastNumber,
    // required this.budget,
    required this.reminderDay,
    required this.isReminder,
    required this.paymentDay,
  });

  final String uid;
  final String customName;
  final String lastNumber;
  //final double budget;
  final String reminderDay;
  final bool isReminder;
  final String paymentDay;
  @override
  List<Object> get props => [
        uid,
        customName,
        lastNumber,
        reminderDay,
        isReminder,
        paymentDay,
      ];
}
// class AddCardRequested extends CardEvent {

//   @override
//   List<Object> get props => [];
// }