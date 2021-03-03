import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_item.dart';
import '../screens/detail_screen.dart';

// TODO: Date formatting

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
            return ListTile(
              title: Text((post['date']).toDate().toString()),
              trailing: Text(post['quantity'].toString()),
              onTap: () {
                postToDetail(context, snapshot, index);
              });
          }))
      ],
    );
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
