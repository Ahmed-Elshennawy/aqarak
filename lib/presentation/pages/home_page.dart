// import 'package:aqarak/core/constants/app_fonts.dart';
// import 'package:aqarak/presentation/cubits/home/home_cubit.dart';
// import 'package:aqarak/presentation/widgets/custom_main_button.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/constants/app_sizes.dart';
// import '../../core/constants/app_strings.dart';
// import '../../core/extensions/context_extensions.dart';
// import '../../data/datasources/home_remote_datasource.dart';
// import '../../data/repositories/home_repository_impl.dart';
// import '../../domain/usecases/fetch_user_profile.dart';

// /// Home screen displaying user information and logout functionality.
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final homeRepository = HomeRepositoryImpl(HomeRemoteDataSource());
//     final fetchUserProfile = FetchUserProfile(homeRepository);
//     final user = FirebaseAuth.instance.currentUser;

//     return BlocProvider(
//       create: (context) => HomeCubit(
//         fetchUserProfile: fetchUserProfile,
//         router: GoRouter.of(context),
//       )..loadUserProfile(user?.uid ?? ''),
//       child: Scaffold(
//         body: BlocConsumer<HomeCubit, HomeState>(
//           listener: (context, state) {
//             if (state is HomeFailure) {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(SnackBar(content: Text(state.message)));
//             }
//           },
//           builder: (context, state) {
//             return Container(
//               width: context.screenWidth,
//               height: context.screenHeight,
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [AppColors.primaryGreen, AppColors.primaryBlue],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(AppSizes.padding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 100),
//                     Text(AppStrings.appName, style: AppFonts.titlePageName),
//                     const SizedBox(height: AppSizes.padding),
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(AppSizes.padding),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             if (state is HomeLoading)
//                               const CircularProgressIndicator(
//                                 color: AppColors.primaryGreen,
//                               ),
//                             if (state is HomeLoaded)
//                               Column(
//                                 children: [
//                                   Text(
//                                     'Welcome, ${state.userProfile.fullName ?? state.userProfile.email}',
//                                     style: AppFonts.titlePageName,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   const SizedBox(height: AppSizes.padding),
//                                   Text(
//                                     'Email: ${state.userProfile.email}',
//                                     style: AppFonts.noteStyle,
//                                   ),
//                                   if (state.userProfile.mobileNumber != null)
//                                     Text(
//                                       'Mobile: ${state.userProfile.mobileNumber}',
//                                       style: AppFonts.noteStyle,
//                                     ),
//                                   const SizedBox(height: AppSizes.padding),
//                                   CustomButton(
//                                     onPressed: () =>
//                                         context.read<HomeCubit>().logout(),
//                                     text: 'Logout',
//                                   ),
//                                 ],
//                               ),
//                             if (state is HomeFailure)
//                               Text(
//                                 state.message,
//                                 style: AppFonts.noteStyle.copyWith(
//                                   color: AppColors.googleRed,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
