import 'package:aqarak/presentation/pages/find_room_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({super.key});

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const FindRoomScreen(),
    const FindRoomScreen(),
    const FindRoomScreen(),
    const FindRoomScreen(),
    // const BookCarScreen(),
    // const CarWashingScreen(),
    // const MyProfileScreen(),
    // const SettingsScreen(),
  ];

  final List<String> _titles = [
    'Find Room',
    'Book a Car',
    'Car Washing',
    'My Profile',
    'Settings',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.room), label: 'Rooms'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Car Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_car_wash),
            label: 'Car Washing',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
