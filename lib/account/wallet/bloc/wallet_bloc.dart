import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc({required this.walletRepository}) : super(WalletState.initial()) {
    on<DisplayWalletRequested>(_onDisplayWalletRequested);
    // on<DisplayCardCashbackRequested>(_onDisplayCardCashbackRequested);
    // on<AddCardRequested>(_onAddCardRequested);
    on<UpdateWalletRequested>(_onUpdateWalletRequested);
     on<DeleteWalletRequested>(_onDeleteWaletRequested);
  }
  _onUpdateWalletRequested(
    UpdateWalletRequested event,
    Emitter emit,
  ) async {
    if (state.status == WalletStatus.loading) return;
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      await walletRepository.updateMyWallet(
        uid: event.uid,
        customName: event.customName,
        //budget: event.budget,
      );

      emit(state.copyWith(
        status: WalletStatus.success,
        success: 'updated',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WalletStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDisplayWalletRequested(
    DisplayWalletRequested event,
    Emitter emit,
  ) async {
    if (state.status == WalletStatus.loading) return;
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      List<Wallet> walletList = await walletRepository.getMyWallets();
      log(walletList.length.toString());
      emit(state.copyWith(
        status: WalletStatus.success,
        success: 'loadedData',
        walletList: walletList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WalletStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDeleteWaletRequested(
    DeleteWalletRequested event,
    Emitter emit,
  ) async {
    if (state.status == WalletStatus.loading) return;
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      await walletRepository.deleteWallet(uid: event.uid);

      emit(state.copyWith(
        status: WalletStatus.success,
        success: 'deleted',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WalletStatus.failure,
        error: e.toString(),
      ));
    }
  }

}
