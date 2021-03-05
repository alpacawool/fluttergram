import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/new_post_form.dart';

/* The new post screen loads the new post form widget that adds a new post
 * to the Firestore posts collection */
class NewPostScreen extends StatelessWidget {
  static const routeName = 'new';

  @override
  Widget build(BuildContext context) {

    final File image = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('New Post')),
        body: NewPostForm(image)
      );
  }
}
