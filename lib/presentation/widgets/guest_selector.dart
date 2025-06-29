import 'package:aqarak/presentation/cubits/find_room/guests_selector_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestsSelector extends StatelessWidget {
  const GuestsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuestsSelectorCubit(),
      child: Column(children: [const _GuestsTile(), const Divider()]),
    );
  }
}

class _GuestsTile extends StatelessWidget {
  const _GuestsTile();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuestsSelectorCubit, GuestsSelectorState>(
      builder: (context, state) {
        return ListTile(
          minLeadingWidth: 0,
          minTileHeight: 40,
          leading: const Icon(Icons.people, color: Colors.blue),
          title: Text(
            '${state.adults} Adults, ${state.children} Children, ${state.rooms} Rooms',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: const Icon(Icons.arrow_drop_down),
          onTap: () => _showGuestsSelector(context),
        );
      },
    );
  }

  void _showGuestsSelector(BuildContext context) {
    final cubit = context.read<GuestsSelectorCubit>();
    GuestsSelectorState currentState = cubit.state;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Select Guests and Rooms',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  NumberPickerWidget(
                    title: 'Adults',
                    value: currentState.adults,
                    onChanged: (value) {
                      setState(() {
                        currentState = currentState.copyWith(adults: value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  NumberPickerWidget(
                    title: 'Children',
                    value: currentState.children,
                    onChanged: (value) {
                      setState(() {
                        currentState = currentState.copyWith(children: value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  NumberPickerWidget(
                    title: 'Rooms',
                    value: currentState.rooms,
                    onChanged: (value) {
                      setState(() {
                        currentState = currentState.copyWith(rooms: value);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      cubit.updateCounts(
                        adults: currentState.adults,
                        children: currentState.children,
                        rooms: currentState.rooms,
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Confirm Selection'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class NumberPickerWidget extends StatelessWidget {
  final String title;
  final int value;
  final ValueChanged<int> onChanged;
  final int minValue;
  final int maxValue;

  const NumberPickerWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: value > minValue ? () => onChanged(value - 1) : null,
            ),
            Text('$value', style: Theme.of(context).textTheme.headlineSmall),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: value < maxValue ? () => onChanged(value + 1) : null,
            ),
          ],
        ),
      ],
    );
  }
}
