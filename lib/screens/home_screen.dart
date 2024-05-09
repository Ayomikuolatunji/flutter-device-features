import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:net_ninja_course/providers/user_places.dart';
import 'package:net_ninja_course/widgets/places_list.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesNotifier.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
      
      body: FutureBuilder(
        future: _placesFuture,
        builder: ((context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PlacesList(
                    placeItems: userPlaces,
                  )),
      ),
    );
  }
}
