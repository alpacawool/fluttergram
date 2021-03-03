import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';

class App extends StatelessWidget {

  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttergram',
      routes: routes
    );
  }
}