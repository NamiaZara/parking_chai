import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/userprovider.dart';
import 'package:user_app/home.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(), // Provide the UserProvider instance
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: 'home',
        routes: {
          'home': (context) => AnimatedPage(),
        },
      ),
    ),
  );
}
