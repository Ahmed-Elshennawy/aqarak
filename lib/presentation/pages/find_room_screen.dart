import 'package:aqarak/presentation/cubits/find_room/find_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindRoomScreen extends StatelessWidget {
  const FindRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FindRoomCubit()..fetchRooms(),
      child: Scaffold(
        body: BlocBuilder<FindRoomCubit, FindRoomState>(
          builder: (context, state) {
            if (state is FindRoomLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FindRoomLoaded) {
              return ListView.builder(
                itemCount: state.rooms.length,
                itemBuilder: (context, index) {
                  final room = state.rooms[index];
                  return ListTile(
                    title: Text(room['name']),
                    subtitle: Text(room['location']),
                  );
                },
              );
            }
            if (state is FindRoomError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Tap to load rooms'));
          },
        ),
      ),
    );
  }
}
