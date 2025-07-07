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
  }) : super(PlacesState());

  Future<void> getAllPlaces() async {
    emit(
      state.copyWith(
        status: PlacesStatus.loading,
        operation: PlaceOperation.allPlaces,
      ),
    );
    final result = await getPlaces();
    result.fold(
      (error) => emit(
        state.copyWith(
          status: PlacesStatus.error,
          operation: PlaceOperation.allPlaces,
          errorMessage: error.toString(),
        ),
      ),
      (places) => emit(
        state.copyWith(
          status: PlacesStatus.loaded,
          operation: PlaceOperation.allPlaces,
          places: places,
        ),
      ),
    );
  }

  Future<void> getNearbyPlaces(String location) async {
    emit(
      state.copyWith(
        status: PlacesStatus.loading,
        operation: PlaceOperation.nearbyPlaces,
      ),
    );
    final result = await getPlacesByLocation(location);
    result.fold(
      (error) => emit(
        state.copyWith(
          status: PlacesStatus.error,
          operation: PlaceOperation.nearbyPlaces,
          errorMessage: error.toString(),
        ),
      ),
      (places) => emit(
        state.copyWith(
          status: PlacesStatus.loaded,
          operation: PlaceOperation.nearbyPlaces,
          nearbyPlaces: places,
        ),
      ),
    );
  }

  Future<void> getBestPlaces(String location) async {
    emit(
      state.copyWith(
        status: PlacesStatus.loading,
        operation: PlaceOperation.bestPlaces,
      ),
    );
    final result = await getPlacesByLocation(location);
    result.fold(
      (error) => emit(
        state.copyWith(
          status: PlacesStatus.error,
          operation: PlaceOperation.bestPlaces,
          errorMessage: error.toString(),
        ),
      ),
      (places) => emit(
        state.copyWith(
          status: PlacesStatus.loaded,
          operation: PlaceOperation.bestPlaces,
          bestPlaces: places,
        ),
      ),
    );
  }

  Future<void> searchPlace({
    required String location,
    required String type,
    required bool isAirConditioned,
  }) async {
    emit(
      state.copyWith(
        status: PlacesStatus.loading,
        operation: PlaceOperation.searchPlaces,
      ),
    );
    final result = await searchPlaces(
      location: location,
      type: type,
      isAirConditioned: isAirConditioned,
    );
    result.fold(
      (error) => emit(
        state.copyWith(
          status: PlacesStatus.error,
          operation: PlaceOperation.searchPlaces,
          errorMessage: error.toString(),
        ),
      ),
      (places) => emit(
        state.copyWith(
          status: PlacesStatus.loaded,
          operation: PlaceOperation.searchPlaces,
          places: places,
        ),
      ),
    );
  }

  Future<void> addNewPlace(Place place) async {
    emit(
      state.copyWith(
        status: PlacesStatus.loading,
        operation: PlaceOperation.addPlace,
      ),
    );
    final result = await addPlace(place);
    result.fold(
      (error) => emit(
        state.copyWith(
          status: PlacesStatus.error,
          operation: PlaceOperation.addPlace,
          errorMessage: error.toString(),
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: PlacesStatus.success,
          operation: PlaceOperation.addPlace,
        ),
      ),
    );
  }
}

enum PlacesStatus { initial, loading, loaded, success, error }

enum PlaceOperation {
  none,
  allPlaces,
  nearbyPlaces,
  bestPlaces,
  searchPlaces,
  addPlace,
}

class PlacesState {
  final PlacesStatus status;
  final PlaceOperation operation;
  final List<Place> places;
  final List<Place> nearbyPlaces;
  final List<Place> bestPlaces;
  final String? errorMessage;

  PlacesState({
    this.status = PlacesStatus.initial,
    this.operation = PlaceOperation.none,
    this.places = const [],
    this.nearbyPlaces = const [],
    this.bestPlaces = const [],
    this.errorMessage,
  });

  PlacesState copyWith({
    PlacesStatus? status,
    PlaceOperation? operation,
    List<Place>? places,
    List<Place>? nearbyPlaces,
    List<Place>? bestPlaces,
    String? errorMessage,
  }) {
    return PlacesState(
      status: status ?? this.status,
      operation: operation ?? this.operation,
      places: places ?? this.places,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      bestPlaces: bestPlaces ?? this.bestPlaces,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
