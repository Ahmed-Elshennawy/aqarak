import 'package:aqarak/data/models/place_model.dart';
import 'package:hive/hive.dart';

class PlaceLocalDataSource {
  static const String boxName = 'places';

  Future<void> init() async {
    await Hive.openBox<PlaceModel>(boxName);
  }

  Future<void> cachePlaces(List<PlaceModel> places) async {
    final box = Hive.box<PlaceModel>(boxName);
    await box.clear();
    for (var place in places) {
      await box.put(place.id, place);
    }
  }

  List<PlaceModel> getCachedPlaces() {
    final box = Hive.box<PlaceModel>(boxName);
    return box.values.toList();
  }

  List<PlaceModel> getCachedPlacesByLocation(String location) {
    final box = Hive.box<PlaceModel>(boxName);
    return box.values
        .where(
          (place) => place.location.toLowerCase() == location.toLowerCase(),
        )
        .toList();
  }
}
