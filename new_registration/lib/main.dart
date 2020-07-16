import 'package:flutter/material.dart';
import 'package:new_registration/registerFirst.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RegisterFirst(title: 'Flutter Demo Home Page'),
    );
  }
}
