import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_global_fair/fruits_fair_bloc.dart';

import 'my_second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => FruitsFairBloc(),
          child: const MyFirstPage(title: 'Global Fair')),
    );
  }
}

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  String? selectedData;
  final TextEditingController _typeAheadController = TextEditingController();
  List<String>? fruits = [
    "Apple",
    "Banana",
    "Coconut",
    "Watermelon",
    "Pomegranate",
    "Orange",
    "Lemon",
    "Grapes"
  ];

  List<String> fetchFilteredList({required String pattern}) {
    List<String>? filterFruits = fruits
        ?.where((element) =>
            (element.toLowerCase()).contains(pattern.toLowerCase()))
        .toList();
    return filterFruits ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
        child: BlocConsumer<FruitsFairBloc, FruitsFairState>(
          listener: (context, state) {
            if (state is ShowMySelectedFruitState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySecondPage(
                    myFavFruit: state.myFavFruit,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TypeAheadField<String?>(
                  suggestionsCallback: (String pattern) {
                    if (pattern.isNotEmpty) {
                      return fetchFilteredList(
                        pattern: pattern,
                      );
                    }
                    return [];
                  },
                  debounceDuration: const Duration(milliseconds: 100),
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      autofocus: true,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder())),
                  itemBuilder: (_, String? value) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value ?? "",
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _typeAheadController.text = suggestion!;
                    selectedData = suggestion;
                  },
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<FruitsFairBloc>(context).add(
                      ShowMySelectedFruitEvent(myFavFruit: selectedData ?? ""),
                    );
                  },
                  child: Container(
                    child: const Text(
                      "Next Page",
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                )
              ],
            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
