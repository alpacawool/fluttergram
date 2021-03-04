import 'package:test/test.dart';
import 'package:fluttergram/models/post_item.dart';

void main() {
  test('Post created from Map should have appropriate property values', () {
    final date = DateTime.now();
    const imageURL = 'www.123.com/image.jpg';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final post_item = PostItem.fromMap({
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    });

    expect(post_item.date, date);
    expect(post_item.imageURL, imageURL);
    expect(post_item.quantity, quantity);
    expect(post_item.latitude, latitude);
    expect(post_item.longitude, longitude);
  });
}
