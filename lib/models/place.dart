import 'dart:io';
import "package:uuid/uuid.dart";

const uuid = Uuid();

class Place {
  Place({required this.title, required this.image, required this.placeDetails})
      : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceDetails placeDetails;
}

class PlaceDetails {
  PlaceDetails(
      {required this.altitude, required this.latitude, required this.address})
      : id = uuid.v4();
  final String id;
  final double latitude;
  final double altitude;
  final String address;
}
