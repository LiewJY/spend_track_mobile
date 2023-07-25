part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final String error;
  final String success;
  final double budget;
  final double spending;
  final List<CardCashback> cashback;

  const HomeState({
    required this.status,
    required this.error,
    required this.success,
    required this.budget,
    required this.spending,
        required this.cashback,

  });

  //initializing
  factory HomeState.initial() {
    return const HomeState(
      status: HomeStatus.initial,
      error: '',
      success: '',
      budget: 0,
      spending: 0,
      cashback:[],
    );
  }

  @override
  List<Object> get props => [status, error];

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    String? success,
    double? budget,
    double? spending,
    List<CardCashback>? cashback,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      success: success ?? this.success,
      budget: budget ?? this.budget,
      spending: spending ?? this.spending,
            cashback: cashback ?? this.cashback,

    );
  }
}
