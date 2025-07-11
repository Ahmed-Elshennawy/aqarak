import 'package:aqarak/domain/entities/place.dart';

class PlaceModel {
  final String userId;
  final String id;
  final String name;
  final String imageUrl;
  final String location;
  final String type;
  final bool isAirConditioned;

  PlaceModel({
    required this.userId,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.type,
    required this.isAirConditioned,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      userId: json['userId'] as String? ?? 'unknown_id',
      id: json['id'] as String? ?? 'unknown_id',
      name: json['name'] as String? ?? 'Unnamed Place',
      imageUrl: json['imageUrl'] as String? ?? '',
      location: json['location'] as String? ?? 'Unknown Location',
      type: json['type'] as String? ?? 'Unknown Type',
      isAirConditioned: json['isAirConditioned'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'location': location,
      'type': type,
      'isAirConditioned': isAirConditioned,
    };
  }

  factory PlaceModel.fromEntity(Place entity) {
    return PlaceModel(
      userId: entity.userId,
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      location: entity.location,
      type: entity.type,
      isAirConditioned: entity.isAirConditioned,
    );
  }

  Place toEntity() {
    return Place(
      userId: userId,
      id: id,
      name: name,
      imageUrl: imageUrl,
      location: location,
      type: type,
      isAirConditioned: isAirConditioned,
    );
  }
}
