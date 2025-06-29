import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ListTile(
            title: Text('Notifications'),
            trailing: Switch(value: true, onChanged: null),
          ),
          ListTile(
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Terms & Conditions'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('About App'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Help & Support'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Rate the MyPass App'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(title: Text('FAQ'), trailing: Icon(Icons.chevron_right)),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.chevron_right, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
