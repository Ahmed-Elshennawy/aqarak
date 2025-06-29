import 'package:flutter_bloc/flutter_bloc.dart';

enum PropertyType { hotels, villas }

class PropertyTypeCubit extends Cubit<PropertyType> {
  PropertyTypeCubit() : super(PropertyType.hotels);

  void selectPropertyType(PropertyType type) => emit(type);
}
