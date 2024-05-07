import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_ninja_course/models/place.dart';
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;
import "package:sqflite/sqflite.dart" as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> databaseConfig() async {
      final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, "placed.db"),
      onCreate: (db, version) => {
            db.execute(
                'CREATE TABLE user_places(id TEXT PRIMARY KEY, title Text, image Text, lat REAL, lng REAL, address Text)')
          },
      version: 1);

  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addNewPlace(Place place) async {
    final appDir = await sysPath.getApplicationCacheDirectory();
    final fileName = path.basename(place.image.path);
    final copiedImage = await place.image.copy("${appDir.path}/$fileName");
    final newPlace = Place(
        title: place.title,
        image: copiedImage,
        placeLocation: place.placeLocation);

    final db = await databaseConfig();
    state = [newPlace, ...state];
    db.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "lat": newPlace.placeLocation.latitude,
      "lng": newPlace.placeLocation.longitude,
      "address": newPlace.placeLocation.address
    });
  }

  void loadPlaces() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await databaseConfig();
    final data=await db.query("SELECT * FROM user_places");

    return data;
  }
}

final userPlacesNotifier =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
        (ref) => UserPlacesNotifier());
