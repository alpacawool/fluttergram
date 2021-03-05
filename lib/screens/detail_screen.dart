import 'package:flutter/material.dart';
import '../models/post_item.dart';
import '../components/flex_text.dart';
import '../styles.dart';

/* The detail screen displays details of a single post
*  including date, image, amount of items, and latitude/longitude */
class DetailScreen extends StatelessWidget {
  static const routeName = 'detail';

  @override
  Widget build(BuildContext context) {
    final PostItem post = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Fluttergram')),
      body: Center(
        child: detailColumn(context, post)
      )
    );
  }

  Widget detailColumn(BuildContext context, PostItem post) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlexText(
            text: post.getShortDate(),
            style: Styles.detailDate,
            flexValue: 2
          ),
          Spacer(flex:1),
          postImage(context, post.imageURL),
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

  Widget postImage(BuildContext context, String url) {
    return Flexible(
      flex: 8,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Semantics(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: imageNetwork(context, url)
          ),       
        label: 'Post Image',
        value: url,
        image: true,
      ))
    );
  }

  /* Noticed that there were delays between images appearing
   * Decided to add a loading indicator while the image loads 
   * This can be done using loadingBuilder. This is based on 
   * https://stackoverflow.com/questions/53577962 */
  Widget imageNetwork(BuildContext context, String url) {
    return Image.network(url, fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget image, 
                      ImageChunkEvent loadStatus) {
        if (loadStatus == null) {
          return image;
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      });
  }
}
