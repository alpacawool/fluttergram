import 'package:flutter/material.dart';
import '../widgets/stream_list.dart';
import '../widgets/camera_button.dart';

/* The list screen has two main features -
 * [1.] Displays the list of posts from Firestore post collection
 *      implemented via StreamBuilder widget (StreamList)
 * [2.] Camera FAB that opens up camera or gallery to select a photo for
 *      a new post */
class ListScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  int totalCount = 0;

  // Extra Credit: Update count in AppBar of total items across all posts
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
