import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/new_post_screen.dart';

/* Floating Action Button on List Screen that opens the camera/gallery
 * and after the file is chosen, navigates to create a post screen */
class CameraButton extends StatelessWidget {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.camera_alt),
      onPressed: () {
        getImage(context);
      },
    );
  }

  void getImage(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pushNewPost(context, File(pickedFile.path));
    }
  }

  void pushNewPost(BuildContext context, File image) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(NewPostScreen.routeName, arguments: image);
  }
}
