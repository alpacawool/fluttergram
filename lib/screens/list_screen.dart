import 'package:flutter/material.dart';
import '../widgets/stream_list.dart';

/* Requirements
    [ ] 1. Display a circular progress indicator when there are no previous posts to display in the LIST SCREEN.
    [ ] 2. The LIST SCREEN should display a list of all previous posts, with the most recent at the top of the list.
    [ ] 3. Each post in the LIST SCREEN should be displayed as a date, representing the date the post was created, 
        and a number, representing the total number of wasted items recorded in the post.
    [ ] 4. Tapping on a post in the LIST SCREEN should cause a Detail Screen to appear. The Detail Screen's back 
        button should cause the LIST SCREEN to appear.
    [ ] 6. The LIST SCREEN should display a large button at the center bottom area of the screen.
*/
class ListScreen extends StatelessWidget {

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Fluttergram')),
      body: StreamList()
    );
  }
}