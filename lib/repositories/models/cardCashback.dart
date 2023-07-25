import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/cashback.dart';
import 'package:track/repositories/models/creditCard.dart';

class CardCashback extends Equatable {
  final CreditCard? card; 
  final List<Cashback>? cashback; 

  const CardCashback({
     this.card,
     this.cashback,
 
  });

  @override
  List<Object?> get props => [card, cashback];
}
