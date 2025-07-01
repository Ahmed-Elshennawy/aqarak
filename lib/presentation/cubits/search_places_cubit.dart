import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/place.dart';
import '../../domain/usecases/get_places_by_location.dart';
import '../../domain/usecases/search_places.dart';
import '../../domain/usecases/add_place.dart';

class SearchPlacesCubit extends Cubit<SearchPlacesState> {
  final SearchPlaces searchPlaces;
  final GetPlacesByLocation getPlacesByLocation;
  final AddPlace addPlace;

  SearchPlacesCubit({
    required this.searchPlaces,
    required this.getPlacesByLocation,
    required this.addPlace,
  }) : super(SearchPlacesInitial());

  DocumentSnapshot? _lastNearbyDoc;
  DocumentSnapshot? _lastBestPlacesDoc;

  Future<void> search({
    required String location,
    required String type,
    required bool isAirConditioned,
  }) async {
    emit(SearchPlacesLoading());
    final result = await searchPlaces(
      location: location,
      type: type,
      isAirConditioned: isAirConditioned,
    );
    result.fold(
      (error) => emit(SearchPlacesError(error.toString())),
      (places) => emit(SearchPlacesLoaded(places: places)),
    );
  }

  Future<void> loadNearbyPlaces(String location) async {
    emit(NearbyPlacesLoading());
    final result = await getPlacesByLocation(location, lastDoc: _lastNearbyDoc);
    result.fold((error) => emit(NearbyPlacesError(error.toString())), (places) {
      _lastNearbyDoc = places.isNotEmpty
          ? places.last as DocumentSnapshot?
          : null;
      emit(NearbyPlacesLoaded(places: places));
    });
  }

  Future<void> loadMoreNearbyPlaces(String location) async {
    if (_lastNearbyDoc == null) return;
    final result = await getPlacesByLocation(location, lastDoc: _lastNearbyDoc);
    result.fold((error) => emit(NearbyPlacesError(error.toString())), (places) {
      _lastNearbyDoc = places.isNotEmpty
          ? places.last as DocumentSnapshot?
          : null;
      emit(
        NearbyPlacesLoaded(
          places: (state as NearbyPlacesLoaded).places + places,
        ),
      );
    });
  }

  Future<void> loadBestPlaces() async {
    emit(BestPlacesLoading());
    final result = await getPlacesByLocation('', lastDoc: _lastBestPlacesDoc);
    result.fold((error) => emit(BestPlacesError(error.toString())), (places) {
      _lastBestPlacesDoc = places.isNotEmpty
          ? places.last as DocumentSnapshot?
          : null;
      emit(BestPlacesLoaded(places: places));
    });
  }

  Future<void> loadMoreBestPlaces() async {
    if (_lastBestPlacesDoc == null) return;
    final result = await getPlacesByLocation('', lastDoc: _lastBestPlacesDoc);
    result.fold((error) => emit(BestPlacesError(error.toString())), (places) {
      _lastBestPlacesDoc = places.isNotEmpty
          ? places.last as DocumentSnapshot?
          : null;
      emit(
        BestPlacesLoaded(places: (state as BestPlacesLoaded).places + places),
      );
    });
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

abstract class SearchPlacesState {}

class SearchPlacesInitial extends SearchPlacesState {}

class SearchPlacesLoading extends SearchPlacesState {}

class SearchPlacesLoaded extends SearchPlacesState {
  final List<Place> places;
  SearchPlacesLoaded({required this.places});
}

class SearchPlacesError extends SearchPlacesState {
  final String message;
  SearchPlacesError(this.message);
}

class NearbyPlacesLoading extends SearchPlacesState {}

class NearbyPlacesLoaded extends SearchPlacesState {
  final List<Place> places;
  NearbyPlacesLoaded({required this.places});
}

class NearbyPlacesError extends SearchPlacesState {
  final String message;
  NearbyPlacesError(this.message);
}

class BestPlacesLoading extends SearchPlacesState {}

class BestPlacesLoaded extends SearchPlacesState {
  final List<Place> places;
  BestPlacesLoaded({required this.places});
}

class BestPlacesError extends SearchPlacesState {
  final String message;
  BestPlacesError(this.message);
}

class AddPlaceLoading extends SearchPlacesState {}

class AddPlaceSuccess extends SearchPlacesState {}

class AddPlaceError extends SearchPlacesState {
  final String message;
  AddPlaceError(this.message);
}
