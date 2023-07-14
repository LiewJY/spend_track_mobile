import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track/repositories/repos/transaction/transaction_repository.dart';

part 'transaction_range_state.dart';

class TransactionRangeCubit extends Cubit<TransactionRangeState> {
  final TransactionRepository transactionRepository;

  TransactionRangeCubit(this.transactionRepository)
      : super(TransactionRangeState.initial());

      getTransactionRange() async {
    if (state.status == TransactionRangeStatus.loading) return;
    emit(state.copyWith(status: TransactionRangeStatus.loading));
    List<String> transactionRange = [];

    try {
      transactionRange = await transactionRepository.getTransactionsRange();
      emit(state.copyWith(
        status: TransactionRangeStatus.success,
        success: 'loadedTransactionRange',
        rangeList: transactionRange,
        // availableSpendingCategoryList: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TransactionRangeStatus.failure,
        error: e.toString(),
      ));
    }

    //     try {
    //   String userID = FirebaseAuth.instance.currentUser!.uid;
    //   await userRef
    //       .doc(userID)
    //       .collection('myTransactions')
    //       .get()
    //       .then((querySnapshot) {
    //     for (var docSnapshot in querySnapshot.docs) {
    //       //transactions.add(docSnapshot.data());
    //       transactionRange.add(docSnapshot.id);
    //       log(docSnapshot.id.toString());
    //     }
    //   });
    //   return transactionRange;
    // } catch (e) {
    //   log(e.toString());
    //   throw 'cannotRetrieveData';
    // }
      }





}
