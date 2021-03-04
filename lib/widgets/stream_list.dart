import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_item.dart';
import '../models/post_list.dart';
import '../screens/detail_screen.dart';
import '../screens/list_screen.dart';

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
            child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var post = snapshot.data.docs[index];
                  postItem.date = post['date'].toDate();
                  postItem.quantity = post['quantity'];
                  return Semantics(
                      child: ListTile(
                          title: Text(postItem.getLongDate()),
                          trailing: Text(postItem.quantity.toString()),
                          onTap: () {
                            postToDetail(context, snapshot, index);
                          }),
                      label: 'Post item in list',
                      value: 'Post date and quantity of items',
                      onTapHint: 'View post detail');
                }))
      ],
    );
  }

  void updateTotalCount(BuildContext context, AsyncSnapshot snapshot) {
    // Update quantity
    var postList = PostList();
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      postList.addPost(
      PostItem(quantity: snapshot.data.docs[i]['quantity']));
    }
    ListScreenState listState = context.findAncestorStateOfType<ListScreenState>();

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
