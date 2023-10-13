import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/transactionSummary.dart';
import 'package:track/repositories/repositories.dart';

part 'monthly_transaction_summary_state.dart';

class MonthlyTransactionSummaryCubit extends Cubit<MonthlyTransactionSummaryState> {
  final TransactionRepository transactionRepository;

  MonthlyTransactionSummaryCubit(this.transactionRepository)
      : super(MonthlyTransactionSummaryState.initial());

  //call repo

  getMonthlyTransactionSummary(String yearMonth) async {
    if (state.status == MonthlyTransactionSummaryStatus.loading) return;
    emit(state.copyWith(status: MonthlyTransactionSummaryStatus.loading));
    try {
      TransactionSummary monthlyTransactionSummary =  await transactionRepository.getMonthlyTransactionSummary(yearMonth);
      emit(state.copyWith(
        status: MonthlyTransactionSummaryStatus.success,
        success: 'loadedMonthlyTransactionSummary',
        monthlyTransactionSummary: monthlyTransactionSummary,
        //rangeList: transactionRange,
        // availableSpendingCategoryList: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MonthlyTransactionSummaryStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
