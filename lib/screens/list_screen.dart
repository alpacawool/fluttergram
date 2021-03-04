import 'package:flutter/material.dart';
import '../widgets/stream_list.dart';
import '../widgets/camera_button.dart';

/* Requirements
    [ ] 1. Display a circular progress indicator when there are no previous posts to display in the LIST SCREEN.
    [ ] 2. The LIST SCREEN should display a list of all previous posts, with the most recent at the top of the list.
    [ ] 3. Each post in the LIST SCREEN should be displayed as a date, representing the date the post was created, 
        and a number, representing the total number of wasted items recorded in the post.
    [ ] 4. Tapping on a post in the LIST SCREEN should cause a Detail Screen to appear. The Detail Screen's back 
        button should cause the LIST SCREEN to appear.
    [ ] 6. The LIST SCREEN should display a large button at the center bottom area of the screen.
    [ ] 7. Tapping on the large button enables an employee to capture a photo, 
           or select a photo from the device's photo gallery.
*/
class ListScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  int totalCount = 0;

  void updateCount(int newCount) {
    totalCount = newCount;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(),
      body: StreamList(),
      floatingActionButton: Semantics(
        child: CameraButton(),
        label: 'Camera button',
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget appBarTitle() {
    if (totalCount == 0) {
      return AppBar(centerTitle: true, title: Text('Fluttergram'));
    } else {
      return AppBar(
        centerTitle: true, title: Text('Fluttergram - $totalCount')
      );
    }
  }
}
