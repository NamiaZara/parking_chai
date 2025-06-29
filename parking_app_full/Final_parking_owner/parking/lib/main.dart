import 'package:flutter/material.dart';
import 'package:parking/home.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark
    ),
    initialRoute: 'home',
    routes: {
      'home' : (context)=>Home(),
    },
  ));
}
