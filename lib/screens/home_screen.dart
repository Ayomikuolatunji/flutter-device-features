import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:net_ninja_course/providers/user_places.dart';
import 'package:net_ninja_course/widgets/places_list.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesNotifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your place"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
              onPressed: () => context.go('/add-new-place'),
              icon: const Icon(Icons.add))
        ],
      ),
      body: PlacesList(
        placeItems: userPlaces,
      ),
    );
  }
}
