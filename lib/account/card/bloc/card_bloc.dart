import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/creditCard.dart';
import 'package:track/repositories/repositories.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final CardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardState.initial()) {
    // on<DisplayAllAvailableCardRequested>(_onDisplayAllAvailableCardRequested);
    // // on<DisplayCardCashbackRequested>(_onDisplayCardCashbackRequested);

    // on<AddCardRequested>(_onAddCardRequested);
    // // on<UpdateCardRequested>(_onUpdateCardRequested);
    //  on<DeleteCardRequested>(_onDeleteCardRequested);
  }

  //actions
  // _onDisplayAllAvailableCardRequested(
  //   DisplayAllAvailableCardRequested event,
  //   Emitter emit,
  // ) async {
  //   if (state.status == CardStatus.loading) return;
  //   emit(state.copyWith(status: CardStatus.loading));
  //   try {
  //     List<CreditCard> cardList = await cardRepository.getAvailableCards();
  //     emit(state.copyWith(
  //       status: CardStatus.success,
  //       success: 'loadedData',
  //       availableCardList: cardList,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       status: CardStatus.failure,
  //       error: e.toString(),
  //     ));
  //   }
  // }
}
