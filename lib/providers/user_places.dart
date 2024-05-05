import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_ninja_course/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addNewPlace(Place place) {
    final newPlace = Place(title: place.title, image: place.image);
    state = [newPlace, ...state];
  }
}

final userPlacesNotifier =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
