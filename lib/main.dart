import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/presentation/cubits/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Aqarak());
}

class Aqarak extends StatelessWidget {
  const Aqarak({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => SplashCubit())],
      child: MaterialApp.router(
        title: AppStrings.appName,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
