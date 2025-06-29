import 'package:aqarak/presentation/cubits/find_room/stay_dates_cubit.dart';
import 'package:aqarak/utils/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StayDatesSelector extends StatelessWidget {
  const StayDatesSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StayDatesCubit(),
      child: Column(
        children: [
          _DateTile(
            type: DateSelectionType.checkIn,
            leadingIcon: Icons.calendar_today,
          ),
          const Divider(),
          const SizedBox(height: 10),
          _DateTile(
            type: DateSelectionType.checkOut,
            leadingIcon: Icons.calendar_today,
          ),
          const Divider(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

enum DateSelectionType { checkIn, checkOut }

class _DateTile extends StatelessWidget {
  final DateSelectionType type;
  final IconData leadingIcon;

  const _DateTile({required this.type, required this.leadingIcon});

  String get title {
    return type == DateSelectionType.checkIn
        ? 'Check-in date & time'
        : 'Check-out date & time';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StayDatesCubit, StayDatesState>(
      builder: (context, state) {
        final dateTime = state is StayDatesLoaded
            ? (type == DateSelectionType.checkIn
                  ? state.checkIn
                  : state.checkOut)
            : null;

        return ListTile(
          minLeadingWidth: 0,
          minTileHeight: 40,
          leading: Icon(leadingIcon, color: Colors.blue, size: 20),
          title: dateTime == null
              ? Text(title)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 2),
                    Text(
                      _formatDateTime(dateTime),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
          trailing: const Icon(Icons.arrow_drop_down),
          onTap: () async {
            final now = DateTime.now();
            final cubit = context.read<StayDatesCubit>();

            // For check-out, don't allow dates before check-in if it exists
            DateTime? firstDate;
            if (type == DateSelectionType.checkOut &&
                state is StayDatesLoaded &&
                state.checkIn != null) {
              firstDate = state.checkIn!;
            }

            final selectedDateTime = await pickDateTime(
              context,
              initialDate: dateTime ?? now,
              firstDate: firstDate,
            );

            if (selectedDateTime != null) {
              if (type == DateSelectionType.checkIn) {
                cubit.updateCheckIn(selectedDateTime);
              } else {
                cubit.updateCheckOut(selectedDateTime);
              }
            }
          },
        );
      },
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${_formatDate(dateTime)} at ${_formatTime(dateTime)}';
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
