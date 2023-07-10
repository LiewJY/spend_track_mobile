part of 'card_bloc.dart';

enum CardStatus { initial, loading, success, failure }

class CardState extends Equatable {
  final CardStatus status;
  final String error;
  final String success;
   final List<CreditCard> availableCardList;
  // final List<Cashback> cashbackList;

  const CardState({
    required this.status,
    required this.error,
    required this.success,
     required this.availableCardList,
    // required this.cashbackList,
  });

  //initializing
  factory CardState.initial() {
    return const CardState(
      status: CardStatus.initial,
      error: '',
      success: '',
      availableCardList: [],
      // cashbackList: [],
    );
  }

  @override
  List<Object> get props => [status, error, success ];

  CardState copyWith({
    CardStatus? status,
    String? error,
    String? success,
     List<CreditCard>? availableCardList,
    // List<Cashback>? cashbackList,
  }) {
    return CardState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
     availableCardList: availableCardList ?? this.availableCardList,
      // cashbackList: cashbackList?? this.cashbackList,
    );
  }
}
