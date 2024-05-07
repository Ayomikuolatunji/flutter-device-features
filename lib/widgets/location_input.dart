import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:net_ninja_course/models/place.dart';
import 'package:net_ninja_course/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocationDetails});
  final void Function(PlaceLocation placeLocation) onSelectLocationDetails;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool _isGettingLocation = false;
  LocationData? _pickedLocation;
  String? key = dotenv.env['GOOGLE_API_KEY'];

  Future savePlace(double lat, double lng) async {
    Uri url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key');

    final res = await http.get(url);
    final resData = json.decode(res.body);
    widget.onSelectLocationDetails(PlaceLocation(
        longitude: lng,
        latitude: lat,
        address: resData["results"][0]["formatted_address"]));
  }

  String get locationImage {
    final double? lat = _pickedLocation!.latitude;
    final double? long = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long=Brooklyn+Bridge,New+York,NY&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C40.$lat,-$long&key=$key';
  }

  void getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      _isGettingLocation = false;
      _pickedLocation = locationData;
      location;
    });
    final double? lat = locationData.latitude;
    final double? lng = locationData.longitude;

    if (lng == null || lat == null) {
      return;
    }

    await savePlace(lat, lng);
  }

  Future _onSelectOnMap() async {
    final pickedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
      builder: (context) {
        return const MapScreen();
      },
    ));

    await savePlace(pickedLocation?.latitude ?? 37.422,
        pickedLocation?.longitude ?? 122.084);
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No location chosen",
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if (_isGettingLocation) {
      previewContent = Text(
        "Loading...",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      );
    }
    print(_pickedLocation);
    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
      );
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                icon: const Icon(Icons.location_on),
                onPressed: getCurrentLocation,
                label: const Text(
                  "Get current location",
                )),
            TextButton.icon(
                icon: const Icon(Icons.map),
                onPressed: () async {
                  await _onSelectOnMap();
                },
                label: const Text(
                  "Select on map",
                ))
          ],
        )
      ],
    );
  }
}
