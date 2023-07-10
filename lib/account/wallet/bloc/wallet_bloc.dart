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
    // on<UpdateCardRequested>(_onUpdateCardRequested);
    // on<DeleteCardRequested>(_onDeleteCardRequested);
  }

  _onDisplayWalletRequested(
    DisplayWalletRequested event,
    Emitter emit,
  ) async {
    if (state.status == WalletStatus.loading) return;
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      //List<Wallet> walletList = await walletRepository.getMyCards();
      emit(state.copyWith(
        status: WalletStatus.success,
        success: 'loadedData',
        //walletList: walletList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: WalletStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
