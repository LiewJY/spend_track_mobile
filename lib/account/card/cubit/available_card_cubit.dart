import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';

part 'available_card_state.dart';

class AvailableCardCubit extends Cubit<AvailableCardState> {
  final CardRepository cardRepository;
  AvailableCardCubit(this.cardRepository) : super(AvailableCardState.initial());

  List<CreditCard> cards = [];
  List<Cashback> cashbacks = [];

  getAvailableCards() async {
    if (state.status == AvailableCardStatus.loading) return;
    emit(state.copyWith(status: AvailableCardStatus.loading));

    try {
      cards = await cardRepository.getAvailableCards();
      emit(state.copyWith(
        status: AvailableCardStatus.success,
        success: 'loadedData',
        availableCardList: cards,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AvailableCardStatus.failure,
        error: e.toString(),
      ));
    }
  }

  addToMyCards(
      {CreditCard? card, String? customName, String? lastNumber}) async {
    if (state.status == AvailableCardStatus.loading) return;
    emit(state.copyWith(status: AvailableCardStatus.loading));

    try {
      final storeCard = CreditCard(
        uid: card!.uid,
        name: card.name,
        bank: card.bank,
        cardType: card.cardType,
        isCashback: card.isCashback,
        customName: customName,
        lastNumber: lastNumber,
        //budget: budget,
      );

      await cardRepository.addToMyCards(storeCard);

      emit(state.copyWith(
        status: AvailableCardStatus.success,
        success: 'added',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AvailableCardStatus.failure,
        error: e.toString(),
      ));
    }
  }

    getCardDetails(String uid) async {
    if (state.status == AvailableCardStatus.loading) return;
    emit(state.copyWith(status: AvailableCardStatus.loading));

    try {
      cashbacks = await cardRepository.getCardDetails(uid);
      cashbacks.forEach((ff) {
        log(ff.formId.toString());
      }

      );
      emit(state.copyWith(
        status: AvailableCardStatus.success,
        success: 'loadedDetailsData',
        cardDetailList: cashbacks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AvailableCardStatus.failure,
        error: e.toString(),
      ));
    }
  }

  // getAvailableCardsInfinity() async {
  //   if (state.status == AvailableCardStatus.loading) return;
  //   emit(state.copyWith(status: AvailableCardStatus.loading));

  //   try {
  //     cards = await cardRepository.getAvailableCardsInfinity();
  //     emit(state.copyWith(
  //       status: AvailableCardStatus.success,
  //       isMax: false,
  //       availableCardList: cards,
  //     ));

  //     // await authRepository.loginWithCredentials(
  //     //     email: email, password: password);
  //     //           emit(state.copyWith(
  //     //   status: AvailableCardStatus.success,
  //     // ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: AvailableCardStatus.failure,
  //       error: e.toString(),
  //     ));
  //   }
  // }
}
