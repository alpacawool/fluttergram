// Each "post" in Firestore should have the following attributes:
// date, imageURL, quantity, latitude and longitude.

class PostItem {
  DateTime date;
  int quantity;
  String imageURL;
  double latitude;
  double longitude;

  PostItem({this.date, this.quantity, this.imageURL, this.latitude, this.longitude});
}
