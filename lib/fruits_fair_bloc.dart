import 'dart:async';

import 'package:bloc/bloc.dart';

part 'fruits_fair_event.dart';

part 'fruits_fair_state.dart';

class FruitsFairBloc extends Bloc<FruitsFairEvent, FruitsFairState> {
  FruitsFairBloc() : super(FruitsFairInitial()) {
    on<ShowMySelectedFruitEvent>(_handleShowMySelectedFruitEvent);
  }

  FutureOr<void> _handleShowMySelectedFruitEvent(
      ShowMySelectedFruitEvent event, Emitter<FruitsFairState> emit) {
    emit(ShowMySelectedFruitState(myFavFruit: event.myFavFruit));
  }
}
