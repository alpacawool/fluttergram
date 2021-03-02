import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Fluttergram')),
      body: Text('List Screen')
    );
  }
}