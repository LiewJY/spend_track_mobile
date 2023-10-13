import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/cardCashback.dart';
import 'package:track/repositories/repos/home/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeState.initial());

  getHomeData() async {
    DateTime now = DateTime.now();
    try {
      List<CardCashback> cashback = await homeRepository.getCashBackSummary();
      double spending = await homeRepository.getSpendingAmount();
      double budget = await homeRepository.getBudgetAmount();
      // log(cashback.toString());

      emit(state.copyWith(
        status: HomeStatus.success,
        success: 'loadedData',
        budget: budget,
        spending: spending,
        cashback: cashback,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
