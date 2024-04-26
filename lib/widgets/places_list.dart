import 'package:flutter/material.dart';
import 'package:net_ninja_course/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.placeItems});

  final List<Place> placeItems;

  @override
  Widget build(BuildContext context) {
    if (placeItems.isEmpty) {
      return const Center(
        child: Text(
          "No places added yet.",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return const Text("");
  }
}
