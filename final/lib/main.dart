import 'package:flutter/material.dart';
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prestige Worldwide',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Register(),
    );
  }
}
