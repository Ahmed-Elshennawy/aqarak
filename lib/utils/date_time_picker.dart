import 'package:flutter/material.dart';

Future<DateTime?> pickDateTime(
  BuildContext context, {
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  // First pick date
  final date = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime.now(),
    lastDate: lastDate ?? DateTime(2100),
  );
  if (date == null) return null;

  // Then pick time
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
  );
  if (time == null) return null;

  // Combine date and time
  return date.copyWith(hour: time.hour, minute: time.minute);
}
