import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/repositories.dart';

part 'card_cashback_state.dart';

class CardCashbackCubit extends Cubit<CardCashbackState> {
  final CardRepository cardRepository;

  CardCashbackCubit(this.cardRepository) : super(CardCashbackState.initial());
  List<Cashback> cashbacks = [];

  getCardDetails(String uid) async {
    if (state.status == CardCashbackStatus.loading) return;
    emit(state.copyWith(status: CardCashbackStatus.loading));

    try {
      cashbacks = await cardRepository.getCardCashbacks(uid);
      cashbacks.forEach((ff) {
        log(ff.formId.toString());
      });
      emit(state.copyWith(
        status: CardCashbackStatus.success,
        success: 'cashbackLoaded',
        cardDetailList: cashbacks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CardCashbackStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
