import 'package:flutter/material.dart';
import 'package:net_ninja_course/models/place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final googleapikey = dotenv.env['GOOGLE_API_KEY'];

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;
  String get locationImage {
    final double lat = place.placeLocation.latitude;
    final double long = place.placeLocation.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=Brooklyn+Bridge,New+York,NY&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C40.$lat,-$long&key=$googleapikey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black54],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Text(
                      place.placeLocation.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
