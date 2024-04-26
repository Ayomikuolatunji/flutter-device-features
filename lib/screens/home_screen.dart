import 'package:flutter/material.dart';
import 'package:net_ninja_course/models/place.dart';
import 'package:net_ninja_course/widgets/places_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Place> placeItems = [Place(title: "Ajegunle")];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your place"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
        ],
      ),
      body: PlacesList(
        placeItems: placeItems,
      ),
    );
  }
}
