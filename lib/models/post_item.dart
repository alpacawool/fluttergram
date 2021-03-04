import 'package:intl/intl.dart';

class PostItem {
  DateTime date;
  int quantity;
  String imageURL;
  double latitude;
  double longitude;

  // Date formatting
  final DateFormat longFormat = DateFormat('EEEE, MMMM d, yyyy');
  final DateFormat shortFormat = DateFormat('EEE, MMM d, yyyy');

  PostItem(
      {this.date, this.quantity, this.imageURL, this.latitude, this.longitude});

  PostItem.fromMap(Map<String, dynamic> map) {
    date = map['date'];
    quantity = map['quantity'];
    imageURL = map['imageURL'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  // Date displayed in list
  String getLongDate() => longFormat.format(date);
  // Date displayed in detail view
  String getShortDate() => shortFormat.format(date);

}
