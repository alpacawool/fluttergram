import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Date formatting

class StreamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('posts').orderBy('date', descending:true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.docs != null &&
              snapshot.data.docs.length > 0) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data.docs[index];
                      return ListTile(
                        title: Text((post['date']).toDate().toString()),
                        trailing: Text(post['amount'].toString()),
                      );
                    }
                  )
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
