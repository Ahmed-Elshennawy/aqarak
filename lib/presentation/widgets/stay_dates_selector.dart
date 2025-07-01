import 'package:aqarak/presentation/cubits/find_room/stay_dates_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StayDatesSelector extends StatelessWidget {
  const StayDatesSelector({super.key});

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final cubit = context.read<StayDatesCubit>();
      if (isCheckIn) {
        cubit.updateDates(checkIn: picked);
      } else {
        cubit.updateDates(checkOut: picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StayDatesCubit, StayDatesState>(
      builder: (context, state) {
        final checkIn = state is StayDatesLoaded ? state.checkIn : null;
        final checkOut = state is StayDatesLoaded ? state.checkOut : null;

        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _selectDate(context, true),
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Check-in'),
                  child: Text(
                    checkIn != null
                        ? DateFormat('yyyy-MM-dd').format(checkIn)
                        : 'Select Date',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: InkWell(
                onTap: () => _selectDate(context, false),
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Check-out'),
                  child: Text(
                    checkOut != null
                        ? DateFormat('yyyy-MM-dd').format(checkOut)
                        : 'Select Date',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
