part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class DisplayWalletRequested extends WalletEvent {
  @override
  List<Object> get props => [];
}