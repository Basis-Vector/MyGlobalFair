import 'package:flutter/material.dart';

class MySecondPage extends StatelessWidget {
  final String myFavFruit;

  const MySecondPage({required this.myFavFruit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(22),
        child: Center(
          child: Text(
            "Hello!, My Favourite Fruit is $myFavFruit",
            style: const TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
      ),
    );
  }
}
