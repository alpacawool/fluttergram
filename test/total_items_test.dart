import 'package:test/test.dart';
import 'package:fluttergram/models/post_item.dart';
import 'package:fluttergram/models/post_list.dart';

void main() {
  test('Total items in post list matches sum of all post item quantities', () {

    final testList = PostList(
      postList: [ 
        PostItem(quantity: 3),
        PostItem(quantity: 4),
        PostItem(quantity: 7)
       ]
    );

    expect(testList.getTotalQuantity(), 14);

  });
}
