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
    if (widget.image == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Form(key: formKey, child: formColumn());
  }

  Widget formColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        postImage(),
        amountNumberField(),
        Spacer(flex: 1),
        uploadButton(),
      ],
    );
  }

  Widget postImage() {
    return Flexible(
      flex: 6,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.fitWidth, 
          child: Image.file(widget.image)
        )
      )
    );
  }

  Widget amountNumberField() {
    return Flexible(
        flex: 1,
        child: TextFormField(
            decoration: InputDecoration(labelText: 'Number of Items'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter number of items';
              } else {
                return null;
              }
            }));
  }

  Widget uploadButton() {
    return Flexible(
        flex: 2,
        child: TextButton(
            child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.contain, 
                  child: Icon(Icons.cloud_upload))
            ),
            onPressed: () {}
          )
    );
  }
}
