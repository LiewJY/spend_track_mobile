import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/transaction.dart';
import 'package:track/repositories/repositories.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  final TransactionRepository transactionRepository;

  AddTransactionCubit(this.transactionRepository)
      : super(AddTransactionState.initial());

  addTransaction(MyTransaction transaction) async {
    //todo remove later
    // log('sdsdsdsdsd');
    // log('log   ' + transaction.toString());

    if (state.status == AddTransactionStatus.loading) return;
    emit(state.copyWith(status: AddTransactionStatus.loading));

    try {
      await transactionRepository.addTransaction(transaction);
      emit(state.copyWith(
        status: AddTransactionStatus.success,
        success: 'transactionAdded',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddTransactionStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
