import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/new_post_form.dart';

/* Requirements
  [ ]  8. After taking a new photo or selecting a photo from the gallery, 
          the NEW POST screen appears.
  [ ]  9. The NEW POST screen displays the photo of wasted food, a Number
          of Items text input field for entering the number of wasted items, 
          and a large upload button for saving the post.
  [ ] 10. Tapping on the Number of Items text input field should cause the 
          device to display its numeric keypad.
  [ ] 11. In the NEW POST screen, tapping the back button in the app bar 
          should cause the List Screen to appear.
  [ ] 12. In the NEW POST screen, tapping the large upload button should 
          cause the List Screen to appear, with the latest post now appearing
           at the top of the list.
  [ ] 13. In the NEW POST screen, if the Number of Items field is empty,
          tapping the upload button should cause a sensible error message 
          to appear.
*/
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
