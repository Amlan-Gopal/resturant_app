import 'package:flutter/material.dart';
import 'package:resturantapp/screens/welcome.dart';

void main() => runApp(ResturantApp());

class ResturantApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resturant App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Welcome()
    );
  }
}
