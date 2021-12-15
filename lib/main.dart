import 'package:flutter/material.dart';
import 'package:word_pair_generator/random_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red[400],
          primaryColorDark: Colors.red[800],
        ),
        home: const RandomWords());
  }
}