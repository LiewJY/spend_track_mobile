import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/repositories.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;
  // TransactionBloc() : super(TransactionInitial()) {
  //   on<TransactionEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

  TransactionBloc({required this.transactionRepository})
      : super(TransactionState.initial()) {
    on<DisplayTransactionRequested>(_onDisplayTransactionRequested);
    // on<DisplayTransactionSummaryRequested>(_onDisplayTransactionSummaryRequested);

    on<UpdateTransactionRequested>(_onUpdateTransactionRequested);
    on<DeleteTransactionRequested>(_onDeleteTransactionRequested);
  }

  List<MyTransaction> transactionList = [];

  _onUpdateTransactionRequested(
    UpdateTransactionRequested event,
    Emitter emit,
  ) async {
    if (state.status == TransactionStatus.loading) return;
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      await transactionRepository.updateTransaction(data: event.data, uid: event.uid, originalYearMonth: event.originalYearMonth);
      emit(state.copyWith(
        status: TransactionStatus.success,
        success: 'updated',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDeleteTransactionRequested(
    DeleteTransactionRequested event,
    Emitter emit,
  ) async {
    if (state.status == TransactionStatus.loading) return;
    emit(state.copyWith(status: TransactionStatus.loading));
    transactionList.clear();
    try {
      transactionRepository.deleteTransaction(data: event.data);

      emit(state.copyWith(
        status: TransactionStatus.success,
        success: 'deleted',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
        error: e.toString(),
      ));
    }
  }

  _onDisplayTransactionRequested(
    DisplayTransactionRequested event,
    Emitter emit,
  ) async {
    if (state.status == TransactionStatus.loading) return;
    emit(state.copyWith(status: TransactionStatus.loading));
    transactionList.clear();
    try {
      transactionList =
          await transactionRepository.getTransactions(event.yearMonth);

      // log(' ccccccc ccc' + transactionList.length.toString());

      // List<MyTransaction> budgetList = await budgetRepository.getMyBudgets();
      emit(state.copyWith(
        status: TransactionStatus.success,
        success: 'loadedData',
        transactionList: transactionList,
        //rangeList: rangeList,
        // budgetList: budgetList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
