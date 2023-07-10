import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/wallet.dart';
import 'package:track/repositories/repos/wallet/wallet_repository.dart';

part 'available_wallet_state.dart';

class AvailableWalletCubit extends Cubit<AvailableWalletState> {
    final WalletRepository walletRepository;

  AvailableWalletCubit(this.walletRepository) : super(AvailableWalletState.initial());

getAvailableWallets() async {
    if (state.status == AvailableWalletStatus.loading) return;
    emit(state.copyWith(status: AvailableWalletStatus.loading));
  List<Wallet> wallets = [];

    try {
      wallets = await walletRepository.getAvailableWallets();
      emit(state.copyWith(
        status: AvailableWalletStatus.success,
        success: 'loadedData',
        availableWalletList: wallets,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AvailableWalletStatus.failure,
        error: e.toString(),
      ));
    }
  }




}
