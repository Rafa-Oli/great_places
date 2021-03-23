const GOOGLE_API_KEY = "AIzaSyCLmZXW7D0-xtdifGE4fnXi7ibzifQMWNQ";

class LocationUtil {
  static String generateLocationPreviewImage({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
