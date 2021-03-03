import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
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

  LocationData locationData;
  var locationService = Location();

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image == null || locationData == null) {
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
                fit: BoxFit.fitWidth, child: Image.file(widget.image))));
  }

  Widget amountNumberField() {
    return Flexible(
        flex: 1,
        child: TextFormField(
            decoration: InputDecoration(labelText: 'Number of Items'),
            keyboardType: TextInputType.number,
            onSaved: (value) {
              postItem.quantity = int.parse(value);
            },
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
                    fit: BoxFit.contain, child: Icon(Icons.cloud_upload))),
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
                uploadImage();
                uploadPost();
                // Go back to previous screen
                Navigator.of(context).pop();
              }
            }));
  }

  void uploadImage() async {
    var imageName = '${DateTime.now().toString()}.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child(imageName);
    UploadTask uploadTask = storageReference.putFile(widget.image);
    await uploadTask;
    postItem.imageURL = await storageReference.getDownloadURL();
  }

  void retrieveLocation() async {
    locationData = await locationService.getLocation();
    setState(() {});
  }

  void uploadPost() {
    postItem.date = DateTime.now();
    postItem.latitude = locationData.latitude;
    postItem.longitude = locationData.longitude;
  
    // Upload to firestore
    FirebaseFirestore.instance.collection('posts').add({
      'date': postItem.date,
      'quantity': postItem.quantity,
      'imageURL': postItem.imageURL,
      'latitude': postItem.latitude,
      'longitude': postItem.longitude
    });
  }
}
