import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBarCubit extends Cubit<bool> {
  CustomAppBarCubit() : super(true);

  void toggleSelection(bool value) => emit(value);
}
