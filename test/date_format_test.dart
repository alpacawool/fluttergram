import 'package:test/test.dart';
import 'package:fluttergram/models/post_item.dart';

void main() {
  test(
      'Date from Post Item formatted in desired format ' +
          '[1: Thursday, January 30, 2020]' +
          '[2: Thu, Jan 30, 2020]', () {

    final post = PostItem(
      imageURL: 'test.com/test.jpg', 
      quantity: 1, 
      date: DateTime.parse('2020-01-30'),
      latitude: 5.0,
      longitude: 4.0
    );

    expect(post.getLongDate(), 'Thursday, January 30, 2020');
    expect(post.getShortDate(), 'Thu, Jan 30, 2020');
  });
}
