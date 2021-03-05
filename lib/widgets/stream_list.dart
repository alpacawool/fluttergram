import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_item.dart';
import '../models/post_list.dart';
import '../screens/detail_screen.dart';
import '../screens/list_screen.dart';
import '../styles.dart';

/* The StreamList class returns a StreamBuilder widget
* that retrieves the posts from Firestore. Empty lists
* display a circular progress indicator. */
class StreamList extends StatelessWidget {
  final postItem = PostItem();

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data.docs != null &&
            snapshot.data.docs.length > 0) {
          updateTotalCount(context, snapshot);
          return listColumn(context, snapshot);
        } else {
          return Center(child: CircularProgressIndicator());
        }
    });
  }

  Widget listColumn(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      children: [
        Expanded(
          child: postListView(context, snapshot)
        )
      ],
    );
  }

  Widget postListView(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
      var post = snapshot.data.docs[index];
      postItem.date = post['date'].toDate();
      postItem.quantity = post['quantity'];
      return Card(
        child: Semantics(
           child: ListTile(
              title: Text(postItem.getLongDate(), style: Styles.tileDate),
              trailing: Text(postItem.quantity.toString(), style: Styles.tileNumber),
              onTap: () {
                postToDetail(context, snapshot, index);
              }),
            label: 'Post item in list',
            value: 'Post date and quantity of items',
            onTapHint: 'View post detail'
        )
      );
    });
  }

  // Extra Credit: Update AppBar in ListScreen
  void updateTotalCount(BuildContext context, AsyncSnapshot snapshot) {
    // Retrieve the total quantities across all existing posts
    var postList = PostList();
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      postList.addPost(
      PostItem(quantity: snapshot.data.docs[i]['quantity']));
    }
    // Retrieve the ListScreen parent to update the AppBar in the Scaffold
    ListScreenState listState
       = context.findAncestorStateOfType<ListScreenState>();
    /* Calling setState functions was not working well with StreamBuilder,
    *  Worked around this issue by using a delayed Future.
    *  https://stackoverflow.com/questions/47592301 */
    Future.delayed(Duration.zero, () async {
      listState.updateCount(postList.getTotalQuantity());
    });
  }

  void postToDetail(BuildContext context, AsyncSnapshot snapshot, int index) {
    // Place data in object before moving screen
    var post = snapshot.data.docs[index];
    postItem.quantity = post['quantity'];
    postItem.date = post['date'].toDate();
    postItem.imageURL = post['imageURL'];
    postItem.latitude = post['latitude'];
    postItem.longitude = post['longitude'];
    // Go to detail screen
    pushDetail(context, postItem);
  }

  void pushDetail(BuildContext context, PostItem post) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(DetailScreen.routeName, arguments: post);
  }
}
