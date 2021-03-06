import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import '../models/post_item.dart';
import '../styles.dart';

/* The new post form widget is displayed after an image from 
 * gallery/camera is selected. It displays the image and allows
 * the user to enter the amount of items in a text field then 
 * upload the image to Firestore. Geolocation and date are recorded
 * with upload. */
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
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        postImage(),
        Spacer(flex: 1),
        amountNumberField(),
        uploadButton(),
      ],
    );
  }

  Widget postImage() {
    return Flexible(
      flex: 7,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.fitWidth, 
          child: Semantics(
            child: Image.file(widget.image),
            label: 'Picture selected for post',
            image: true,
            readOnly: true,
          )
        )
      )
    );
  }

  Widget amountNumberField() {
    return Flexible(
      flex: 4,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: semanticAmountField()
      )
    );
  }

  Widget semanticAmountField() {
    return Semantics(
      child:TextFormField(
        style: Styles.numberField,
        decoration: InputDecoration(
          labelText: 'Number of Items',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide()
          )
        ),
        // Forces the keyboard to be a numeric keyboard
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
        }),
        label: 'Quantity Text Field',
        value: 'Number of Items',
        onTapHint: 'Enter a numeric integer of how many items',
        textField: true,
        multiline: false, 
    );
  }

  Widget uploadButton() {
    return Flexible(
      flex: 3,
      child: Semantics(
        child:TextButton(
          child: cloudBox(),
          onPressed: () {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              uploadPost();
              // Go back to previous screen
               Navigator.of(context).pop();
              }
            }
          ),
        label: 'Upload Post Button',
        onTapHint: 'Upload image with quantity and geolocation to cloud',
        button: true,
        enabled: true,
      )
    );
  }

  Widget cloudBox() {
    return SizedBox.expand(
      child: Container(
        child: FittedBox(
          fit: BoxFit.contain, 
          child: Icon(Icons.cloud_upload, color: Colors.white)
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.all(Radius.circular(20))
        )
      )
    );
  }

  // Uploads image to storage
  Future uploadImage() async {
    var imageName = '${DateTime.now().toString()}.jpg';
    Reference storageReference =
        FirebaseStorage.instance.ref().child(imageName);
    UploadTask uploadTask = storageReference.putFile(widget.image);
    await uploadTask;
    postItem.imageURL = await storageReference.getDownloadURL();
  }
  // Uses location package to retrieve GPS coordinates
  void retrieveLocation() async {
    locationData = await locationService.getLocation();
    setState(() {});
  }

  void uploadPost() async{
    await uploadImage();
    postItem.date = DateTime.now();
    postItem.latitude = locationData.latitude;
    postItem.longitude = locationData.longitude;

    // Upload post attributes to firestore
    FirebaseFirestore.instance.collection('posts').add({
      'date': postItem.date,
      'quantity': postItem.quantity,
      'imageURL': postItem.imageURL,
      'latitude': postItem.latitude,
      'longitude': postItem.longitude
    });
  }
}
