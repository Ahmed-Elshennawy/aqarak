import 'package:aqarak/domain/usecases/get_places.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/place.dart';
import '../../domain/usecases/get_places_by_location.dart';
import '../../domain/usecases/search_places.dart';
import '../../domain/usecases/add_place.dart';

class PlacesCubit extends Cubit<PlacesState> {
  final GetPlaces getPlaces;
  final SearchPlaces searchPlaces;
  final GetPlacesByLocation getPlacesByLocation;
  final AddPlace addPlace;

  PlacesCubit({
    required this.getPlaces,
    required this.searchPlaces,
    required this.getPlacesByLocation,
    required this.addPlace,
  }) : super(PlacesInitial());

  Future<void> places() async {
    emit(PlacesLoading());
    final result = await getPlaces();
    result.fold(
      (error) => emit(PlacesError(error.toString())),
      (places) => emit(PlacesLoaded(places: places)),
    );
  }

  Future<void> nearbyPlaces(String location) async {
    emit(NearbyPlacesLoading());
    final result = await getPlacesByLocation(location);
    result.fold(
      (error) => emit(NearbyPlacesError(error.toString())),
      (places) => emit(NearbyPlacesLoaded(places: places)),
    );
  }

  Future<void> loadBestPlaces(String location) async {
    emit(BestPlacesLoading());
    final result = await getPlacesByLocation(location);
    result.fold(
      (error) => emit(BestPlacesError(error.toString())),
      (places) => emit(BestPlacesLoaded(places: places)),
    );
  }

  Future<void> search({
    required String location,
    required String type,
    required bool isAirConditioned,
  }) async {
    emit(PlacesLoading());
    final result = await searchPlaces(
      location: location,
      type: type,
      isAirConditioned: isAirConditioned,
    );
    result.fold(
      (error) => emit(PlacesError(error.toString())),
      (places) => emit(PlacesLoaded(places: places)),
    );
  }

  Future<void> addNewPlace(Place place) async {
    emit(AddPlaceLoading());
    final result = await addPlace(place);
    result.fold(
      (error) => emit(AddPlaceError(error.toString())),
      (_) => emit(AddPlaceSuccess()),
    );
  }
}

abstract class PlacesState {}

class PlacesInitial extends PlacesState {}

class PlacesLoading extends PlacesState {}

class PlacesLoaded extends PlacesState {
  final List<Place> places;
  PlacesLoaded({required this.places});
}

class PlacesError extends PlacesState {
  final String message;
  PlacesError(this.message);
}

class NearbyPlacesLoading extends PlacesState {}

class NearbyPlacesLoaded extends PlacesState {
  final List<Place> places;
  NearbyPlacesLoaded({required this.places});
}

class NearbyPlacesError extends PlacesState {
  final String message;
  NearbyPlacesError(this.message);
}

class BestPlacesLoading extends PlacesState {}

class BestPlacesLoaded extends PlacesState {
  final List<Place> places;
  BestPlacesLoaded({required this.places});
}

class BestPlacesError extends PlacesState {
  final String message;
  BestPlacesError(this.message);
}

class AddPlaceLoading extends PlacesState {}

class AddPlaceSuccess extends PlacesState {}

class AddPlaceError extends PlacesState {
  final String message;
  AddPlaceError(this.message);
}
