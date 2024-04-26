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
    return ListView.builder(
      itemBuilder: ((ctx, index) => ListTile(
            title: Text(
              placeItems[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          )),
      itemCount: placeItems.length,
    );
  }
}
