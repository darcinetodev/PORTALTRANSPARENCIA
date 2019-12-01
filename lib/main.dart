import 'package:flutter/material.dart';
import 'package:portaltransparencia/View/LoginView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal da Transparência',
      home: LoginView()
    );
  }
}