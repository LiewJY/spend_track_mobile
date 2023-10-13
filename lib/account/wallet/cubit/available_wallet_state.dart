part of 'available_wallet_cubit.dart';

enum AvailableWalletStatus { initial, loading, success, failure }

class AvailableWalletState extends Equatable {
  final AvailableWalletStatus status;
  final String error;
  final String success;
  // final bool isMax;

   final List<Wallet> availableWalletList;
  // final List<Cashback> cardDetailList;

  const AvailableWalletState({
    required this.status,
    required this.error,
    required this.success,
    // //fixme not use ismax
    // required this.isMax,
    required this.availableWalletList,
    // required this.cardDetailList,
  });

  //initializing
  factory AvailableWalletState.initial() {
    return const AvailableWalletState(
      status: AvailableWalletStatus.initial,
      error: '',
      success: '',
      // isMax: false,
      availableWalletList: [],
      // cardDetailList: [],
    );
  }

  @override
  List<Object> get props => [status, error];

  AvailableWalletState copyWith({
    AvailableWalletStatus? status,
    String? error,
    String? success,
    // bool? isMax,
     List<Wallet>? availableWalletList,
    // List<Cashback>? cardDetailList,
  }) {
    return AvailableWalletState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      // isMax: isMax ?? this.isMax,
      availableWalletList: availableWalletList ?? this.availableWalletList,
      // cardDetailList: cardDetailList ?? this.cardDetailList,
    );
  }
}
