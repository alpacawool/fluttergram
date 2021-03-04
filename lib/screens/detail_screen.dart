import 'package:flutter/material.dart';
import '../models/post_item.dart';
import '../components/flex_text.dart';
import '../styles.dart';

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
        child: detailColumn(post)
      )
    );
  }

  Widget detailColumn(PostItem post) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlexText(
            text: post.getShortDate(),
            style: Styles.detailDate,
            flexValue: 2
          ),
          Spacer(flex:1),
          postImage(post.imageURL),
          Spacer(flex:1),
          FlexText(
            text: '${post.quantity.toString()} items',
            style: Styles.detailItems,
            flexValue: 2,
          ),
          Spacer(flex:1),
          FlexText(
          text: 'Location: (${post.latitude.toString()},'
                 +'${post.longitude.toString()})',
          style: Styles.detailLocate,
          flexValue: 1
          )
        ],
      );
  }

  Widget postImage(String url) {
    return Flexible(
        flex: 8,
        child: SizedBox.expand(
            child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Semantics(
            child:Image.network(url),
            label: 'Post Image',
            value: url,
            image: true,
          )
        )
      )
    );
  }
}
