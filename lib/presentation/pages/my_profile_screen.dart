import 'package:aqarak/presentation/cubits/my_profile/my_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProfileCubit()..fetchUserProfile(),
      child: Scaffold(
        body: BlocBuilder<MyProfileCubit, MyProfileState>(
          builder: (context, state) {
            if (state is MyProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MyProfileLoaded) {
              return Column(
                children: [
                  Text('Name: ${state.userProfile.fullName}'),
                  Text('Email: ${state.userProfile.email}'),
                  Text('Mobile: ${state.userProfile.mobileNumber}'),
                ],
              );
            }
            if (state is MyProfileError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Tap to load profile'));
          },
        ),
      ),
    );
  }
}
