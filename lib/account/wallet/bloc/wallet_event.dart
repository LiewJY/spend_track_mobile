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

class UpdateWalletRequested extends WalletEvent {
  const UpdateWalletRequested({
    required this.uid,
    required this.customName,
  });

  final String uid;
  final String customName;

  @override
  List<Object> get props => [
        uid,
        customName,
      ];
}

class DeleteWalletRequested extends WalletEvent {
  const DeleteWalletRequested({required this.uid});

  final String uid;

  @override
  List<Object> get props => [uid];
}