import 'package:aqarak/data/datasources/place_remote_datasource.dart';
import 'package:aqarak/data/repositories/place_repository_impl.dart';
import 'package:aqarak/domain/usecases/add_place.dart';
import 'package:aqarak/domain/usecases/get_places.dart';
import 'package:aqarak/domain/usecases/get_places_by_location.dart';
import 'package:aqarak/domain/usecases/search_places.dart';
import 'package:aqarak/presentation/cubits/places_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
import 'package:aqarak/presentation/widgets/location_search_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../core/constants/app_sizes.dart';
import '../../domain/entities/place.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  AddPlaceScreenState createState() => AddPlaceScreenState();
}

class AddPlaceScreenState extends State<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String _type = 'Hotel';
  bool _isAirConditioned = false;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  String? _validateImageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an image URL';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesCubit(
        getPlaces: GetPlaces(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
        searchPlaces: SearchPlaces(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
        getPlacesByLocation: GetPlacesByLocation(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
        addPlace: AddPlace(
          PlaceRepositoryImpl(remoteDataSource: PlaceRemoteDataSource()),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Place')),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Place Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name' : null,
                  ),
                  SizedBox(height: AppSizes.padding),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    validator: _validateImageUrl,
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: AppSizes.padding),
                  LocationSearchField(
                    isSearch: false,
                    label: 'Location',
                    onLocationSelected: (p0) {
                      _locationController.text = p0;
                    },
                  ),
                  SizedBox(height: AppSizes.padding),
                  DropdownButtonFormField<String>(
                    value: _type,
                    items: ['Hotel', 'Villa']
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                    onChanged: (value) => setState(() => _type = value!),
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                  SizedBox(height: AppSizes.padding),
                  CheckboxListTile(
                    title: const Text('Air Conditioned'),
                    value: _isAirConditioned,
                    onChanged: (value) =>
                        setState(() => _isAirConditioned = value!),
                  ),
                  const SizedBox(height: 290),
                  BlocConsumer<PlacesCubit, PlacesState>(
                    listener: (context, state) {
                      if (state.status == PlacesStatus.success &&
                          state.operation == PlaceOperation.addPlace) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Place added successfully'),
                          ),
                        );
                      } else if (state.status == PlacesStatus.error &&
                          state.operation == PlaceOperation.addPlace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.errorMessage ?? 'Error adding place',
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<PlacesCubit>().addNewPlace(
                              Place(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                id: const Uuid().v4(),
                                name: _nameController.text,
                                imageUrl: _imageUrlController.text,
                                location: _locationController.text,
                                type: _type,
                                isAirConditioned: _isAirConditioned,
                              ),
                            );
                          }
                        },
                        text: 'Add Place',
                        isLoading:
                            state.status == PlacesStatus.loading &&
                            state.operation == PlaceOperation.addPlace,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
