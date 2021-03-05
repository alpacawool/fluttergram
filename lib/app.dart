import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/new_post_screen.dart';

class App extends StatelessWidget {

  // Routing to each screen
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    DetailScreen.routeName: (context) => DetailScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttergram',
      routes: routes
    );
  }
}