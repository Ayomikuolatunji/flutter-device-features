import 'package:flutter/material.dart';
import 'package:net_ninja_course/models/place.dart';
import 'package:net_ninja_course/screens/place_detail_screen.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.placeItems});

  final List<Place> placeItems;

  void onViewDetailPlace(BuildContext context, Place place) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => PlaceDetailScreen(place: (place))));
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemBuilder: ((ctx, index) => ListTile(
              onTap: () {
                onViewDetailPlace(context, placeItems[index]);
              },
              leading: CircleAvatar(
                  backgroundImage: FileImage(placeItems[index].image)),
              title: Text(
                placeItems[index].title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                placeItems[index].placeLocation.address,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Icon(Icons.more_vert),
              ),
            )),
        itemCount: placeItems.length,
      ),
    );
  }
}
