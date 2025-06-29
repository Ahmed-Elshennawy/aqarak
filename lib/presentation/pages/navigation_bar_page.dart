import 'package:aqarak/core/constants/app_colors.dart';
import 'package:aqarak/core/constants/app_fonts.dart';
import 'package:aqarak/presentation/pages/book_car_screen.dart';
import 'package:aqarak/presentation/pages/car_washing_screen.dart';
import 'package:aqarak/presentation/pages/find_room_screen.dart';
import 'package:aqarak/presentation/pages/my_profile_screen.dart';
import 'package:aqarak/presentation/pages/settings_screen.dart';
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
    const BookCarScreen(),
    const CarWashingScreen(),
    const MyProfileScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryBlue, AppColors.primaryGreen],
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.textDark,
          unselectedItemColor: AppColors.unselectedItemColor,
          showUnselectedLabels: false,
          selectedLabelStyle: AppFonts.captionRegularStyle,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.house), label: 'Rooms'),
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
      ),
    );
  }
}
