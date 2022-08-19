part of 'fruits_fair_bloc.dart';

abstract class FruitsFairEvent {}

class ShowMySelectedFruitEvent extends FruitsFairEvent {
  String myFavFruit;

  ShowMySelectedFruitEvent({required this.myFavFruit});
}
