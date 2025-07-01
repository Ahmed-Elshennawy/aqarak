import 'package:hive/hive.dart';
import 'place_model.dart';

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final typeId = 0;

  @override
  PlaceModel read(BinaryReader reader) {
    return PlaceModel(
      id: reader.readString(),
      name: reader.readString(),
      imageUrl: reader.readString(),
      location: reader.readString(),
      type: reader.readString(),
      isAirConditioned: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.imageUrl);
    writer.writeString(obj.location);
    writer.writeString(obj.type);
    writer.writeBool(obj.isAirConditioned);

  }
}
