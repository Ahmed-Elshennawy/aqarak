import 'package:aqarak/data/datasources/loca_datassources/place_local_datastore.dart';
import 'package:aqarak/data/datasources/remote_datasources/place_remote_datasource.dart';
import 'package:aqarak/data/repositories/place_repository_impl.dart';
import 'package:aqarak/domain/usecases/add_place.dart';
import 'package:aqarak/domain/usecases/get_places_by_location.dart';
import 'package:aqarak/domain/usecases/search_places.dart';
import 'package:aqarak/presentation/cubits/search_places_cubit.dart';
import 'package:aqarak/presentation/widgets/custom_main_button.dart';
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
  final _imageUrlController =
      TextEditingController(); // New controller for image URL
  String _type = 'Hotel';
  bool _isAirConditioned = false;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _imageUrlController.dispose(); // Dispose new controller
    super.dispose();
  }

  // Validate URL format
  String? _validateImageUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an image URL';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPlacesCubit(
        searchPlaces: SearchPlaces(
          PlaceRepositoryImpl(
            remoteDataSource: PlaceRemoteDataSource(),
            localDataSource: PlaceLocalDataSource(),
          ),
        ),
        getPlacesByLocation: GetPlacesByLocation(
          PlaceRepositoryImpl(
            remoteDataSource: PlaceRemoteDataSource(),
            localDataSource: PlaceLocalDataSource(),
          ),
        ),
        addPlace: AddPlace(
          PlaceRepositoryImpl(
            remoteDataSource: PlaceRemoteDataSource(),
            localDataSource: PlaceLocalDataSource(),
          ),
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
                  // PLACE NAME TEXT FIELD
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Place Name'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a name' : null,
                  ),
                  SizedBox(height: AppSizes.padding),
                  // IMAGE URL TEXT FIELD
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(labelText: 'Image URL'),
                    validator: _validateImageUrl,
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(height: AppSizes.padding),
                  // THE PLACE LOCATION TEXT FIELD
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Location'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a location' : null,
                  ),
                  SizedBox(height: AppSizes.padding),
                  // THE PLACE TYPE (HOTEL or VILLA)
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
                  // IS AIR CONDITIONED OR NOT
                  CheckboxListTile(
                    title: const Text('Air Conditioned'),
                    value: _isAirConditioned,
                    onChanged: (value) =>
                        setState(() => _isAirConditioned = value!),
                  ),
                  const SizedBox(height: 290),
                  // THE ADD PLACE BUTTON
                  BlocConsumer<SearchPlacesCubit, SearchPlacesState>(
                    listener: (context, state) {
                      if (state is AddPlaceSuccess) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Place added successfully'),
                          ),
                        );
                      } else if (state is AddPlaceError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SearchPlacesCubit>().addNewPlace(
                              Place(
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
                        isLoading: state is AddPlaceLoading,
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
