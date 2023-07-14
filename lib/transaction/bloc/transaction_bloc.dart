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

    // on<UpdateWalletRequested>(_onUpdateWalletRequested);
    //  on<DeleteWalletRequested>(_onDeleteWaletRequested);
  }

  _onDisplayTransactionRequested(
    DisplayTransactionRequested event,
    Emitter emit,
  ) async {
    if (state.status == TransactionStatus.loading) return;
    emit(state.copyWith(status: TransactionStatus.loading));
    try {
      List<MyTransaction> transactionList =
          await transactionRepository.getTransactions(event.yyyyMm);

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
