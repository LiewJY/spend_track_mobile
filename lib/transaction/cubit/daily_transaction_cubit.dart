import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/repositories.dart';

part 'daily_transaction_state.dart';

class DailyTransactionCubit extends Cubit<DailyTransactionState> {
  final TransactionRepository transactionRepository;
  DailyTransactionCubit(this.transactionRepository)
      : super(DailyTransactionState.initial());

  //todo
  getDailyTransaction(DateTime date) async {
    if (state.status == DailyTransactionStatus.loading) return;
    emit(state.copyWith(status: DailyTransactionStatus.loading));
    List<MyTransaction> transactions;

    try {
      //todo get the data and return it

      // log('cubit    ' + date.toString());
      transactions = await transactionRepository.getTransactionsByDate(date);
      emit(state.copyWith(
        status: DailyTransactionStatus.success,
        success: 'loadedData',
        transactionList: transactions,
        //todo
        //rangeList: DailyTransactionStatus,
        // availableSpendingCategoryList: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DailyTransactionStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
