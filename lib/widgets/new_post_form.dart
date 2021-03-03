import 'dart:io';
import 'package:flutter/material.dart';
import '../models/post_item.dart';

class NewPostForm extends StatefulWidget {
  final File image;

  NewPostForm(this.image);

  File getImage() {
    return image;
  }

  @override
  _NewPostFormState createState() => _NewPostFormState();
}

class _NewPostFormState extends State<NewPostForm> {
  final formKey = GlobalKey<FormState>();
  final postItem = PostItem();

  @override
  Widget build(BuildContext context) {
    return Form(key: formKey, child: formColumn());
  }

  Widget formColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        postImage(),
        amountNumberField(),
      ],
    );
  }

  Widget postImage() {
    return Flexible(child: Image.file(widget.image));
  }

  Widget amountNumberField() {
    return Flexible(
      child:TextFormField(
        decoration: InputDecoration(
          labelText: 'Number of Items'
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter number of items';
          } else {
            return null;
          }
        }
      )
    );
  }
}
