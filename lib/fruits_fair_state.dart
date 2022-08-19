part of 'fruits_fair_bloc.dart';

abstract class FruitsFairState {}

class FruitsFairInitial extends FruitsFairState {}

class ShowMySelectedFruitState extends FruitsFairState {
  String myFavFruit;

  ShowMySelectedFruitState({required this.myFavFruit});
}
