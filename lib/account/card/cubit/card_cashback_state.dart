part of 'card_cashback_cubit.dart';

enum CardCashbackStatus { initial, loading, success, failure }




class CardCashbackState extends Equatable {
  final CardCashbackStatus status;
  final String error;
  final String success;

  final List<Cashback> cardDetailList;

  const CardCashbackState({
    required this.status,
    required this.error,
    required this.success,
    required this.cardDetailList,
  });

  //initializing
  factory CardCashbackState.initial() {
    return const CardCashbackState(
      status: CardCashbackStatus.initial,
      error: '',
      success: '',
      cardDetailList: [],
    );
  }

  @override
  List<Object> get props => [status, error];

  CardCashbackState copyWith({
    CardCashbackStatus? status,
    String? error,
    String? success,
    List<Cashback>? cardDetailList,
  }) {
    return CardCashbackState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      cardDetailList: cardDetailList ?? this.cardDetailList,
    );
  }
}
