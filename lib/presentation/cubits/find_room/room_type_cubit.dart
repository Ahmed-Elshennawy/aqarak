import 'package:flutter_bloc/flutter_bloc.dart';

class RoomTypeCubit extends Cubit<bool> {
  RoomTypeCubit() : super(false); // false = Fan, true = AC

  void selectRoomType(bool isAc) {
    emit(isAc);
  }
}
