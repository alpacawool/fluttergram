import 'post_item.dart';
// The PostList model represents an entire collection of posts
class PostList {
  List<PostItem> postList;

  PostList({this.postList = const []});

  void addPost(PostItem post) {
    if (postList.isEmpty) {
      postList = [post];
    } else {
      postList.add(post);
    }
  }

  int getTotalQuantity() {
    int totalQuantity = 0;
    for (int i = 0; i < postList.length; i++) {
      totalQuantity += postList[i].quantity;
    }
    return totalQuantity;
  }
}
