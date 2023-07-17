import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'daily_transaction_summary_state.dart';

class DailyTransactionSummaryCubit extends Cubit<DailyTransactionSummaryState> {
  DailyTransactionSummaryCubit() : super(DailyTransactionSummaryState.initial());

  getDailyTransaction() {
    
  }
}


