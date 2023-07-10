part of 'available_card_cubit.dart';

enum AvailableCardStatus { initial, loading, success, failure }

class AvailableCardState extends Equatable {
  final AvailableCardStatus status;
  final String error;
  final String success;
  final bool isMax;

  final List<CreditCard> availableCardList;
  final List<Cashback> cardDetailList;

  const AvailableCardState({
    required this.status,
    required this.error,
    required this.success,
    //fixme not use ismax
    required this.isMax,
    required this.availableCardList,
    required this.cardDetailList,
  });

  //initializing
  factory AvailableCardState.initial() {
    return const AvailableCardState(
      status: AvailableCardStatus.initial,
      error: '',
      success: '',
      isMax: false,
      availableCardList: [],
      cardDetailList: [],
    );
  }

  @override
  List<Object> get props => [status, error];

  AvailableCardState copyWith({
    AvailableCardStatus? status,
    String? error,
    String? success,
    bool? isMax,
    List<CreditCard>? availableCardList,
    List<Cashback>? cardDetailList,
  }) {
    return AvailableCardState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      isMax: isMax ?? this.isMax,
      availableCardList: availableCardList ?? this.availableCardList,
      cardDetailList: cardDetailList ?? this.cardDetailList,
    );
  }
}
