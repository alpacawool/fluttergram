import 'package:flutter/material.dart';
import '../models/post_item.dart';

/*
  5. [ ] The Detail Screen should display the post's date, 
         photo, number of wasted items, and the latitude and 
         longitude that was recorded as part of the post.
*/

class DetailScreen extends StatelessWidget {
  static const routeName = 'detail';

  @override
  Widget build(BuildContext context) {

    final PostItem post = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Fluttergram')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(post.date.toString()),
            Image(image: NetworkImage(post.imageURL)),
            Text(post.quantity.toString()),
            Text(post.latitude.toString()),
            Text(post.longitude.toString())
          ],
        ),
      )
    );
  }
}
