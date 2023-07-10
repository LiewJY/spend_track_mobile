import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardState.initial()) {
    on<DisplayCardRequested>(_onDisplayCardRequested);
    on<DisplayCardCashbackRequested>(_onDisplayCardCashbackRequested);
    // on<AddCardRequested>(_onAddCardRequested);
    on<UpdateCardRequested>(_onUpdateCardRequested);
    on<DeleteCardRequested>(_onDeleteCardRequested);
  }

  // actions
  _onUpdateCardRequested(
    UpdateCardRequested event,
    Emitter emit,
  ) async {
    if (state.status == CardStatus.loading) return;
    emit(state.copyWith(status: CardStatus.loading));
    try {
      await cardRepository.updateMyCard(
        uid: event.uid,
        customName: event.customName,
        lastNumber: event.lastNumber,
        budget: event.budget,
      );

      emit(state.copyWith(
        status: CardStatus.success,
        success: 'updated',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CardStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDisplayCardCashbackRequested(
    DisplayCardCashbackRequested event,
    Emitter emit,
  ) async {
    if (state.status == CardStatus.loading) return;
    emit(state.copyWith(status: CardStatus.loading));
    try {
      List<Cashback> cashbackList =
          await cardRepository.getCardCashbacks(event.uid);
      emit(state.copyWith(
        status: CardStatus.success,
        success: 'cashbackLoaded',
        cashbackList: cashbackList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CardStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDisplayCardRequested(
    DisplayCardRequested event,
    Emitter emit,
  ) async {
    if (state.status == CardStatus.loading) return;
    emit(state.copyWith(status: CardStatus.loading));
    try {
      List<CreditCard> cardList = await cardRepository.getMyCards();
      emit(state.copyWith(
        status: CardStatus.success,
        success: 'loadedData',
        cardList: cardList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CardStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDeleteCardRequested(
    DeleteCardRequested event,
    Emitter emit,
  ) async {
    if (state.status == CardStatus.loading) return;
    emit(state.copyWith(status: CardStatus.loading));
    try {
      await cardRepository.deleteCard(uid: event.uid);

      emit(state.copyWith(
        status: CardStatus.success,
        success: 'deleted',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CardStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
