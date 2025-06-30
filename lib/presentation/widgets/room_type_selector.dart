import 'package:aqarak/presentation/cubits/find_room/room_type_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomTypeSelector extends StatelessWidget {
  const RoomTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomTypeCubit(),
      child: const _RoomTypeRadioButtons(),
    );
  }
}

class _RoomTypeRadioButtons extends StatelessWidget {
  const _RoomTypeRadioButtons();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomTypeCubit, bool>(
      builder: (context, isAcSelected) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: RadioListTile<bool>(
                contentPadding: EdgeInsets.zero,
                title: const Text('Fan'),
                value: false,
                groupValue: isAcSelected,
                onChanged: (value) {
                  context.read<RoomTypeCubit>().selectRoomType(false);
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: RadioListTile<bool>(
                contentPadding: EdgeInsets.zero,
                title: const Text('Air conditioned'),
                value: true,
                groupValue: isAcSelected,
                onChanged: (value) {
                  context.read<RoomTypeCubit>().selectRoomType(true);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
