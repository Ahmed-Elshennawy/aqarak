import 'package:aqarak/data/datasources/home_remote_datasource.dart';
import 'package:aqarak/data/repositories/home_repository_impl.dart';
import 'package:aqarak/domain/usecases/fetch_user_profile.dart';
import 'package:aqarak/presentation/cubits/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepository = HomeRepositoryImpl(HomeRemoteDataSource());
    final fetchUserProfile = FetchUserProfile(homeRepository);
    return Scaffold(
      body: ListView(
        children: [
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
          BlocProvider(
            create: (context) => HomeCubit(
              fetchUserProfile: fetchUserProfile,
              router: GoRouter.of(context),
            ),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().logout();
                  },
                  child: ListTile(
                    title: Text('Logout'),
                    trailing: Icon(Icons.chevron_right, color: Colors.red),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
