// lib/main.dart
import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/domain/usecases/reset_password.dart';
import 'package:aqarak/domain/usecases/sign_in.dart';
import 'package:aqarak/domain/usecases/sign_up.dart';
import 'package:aqarak/domain/usecases/verify_otp.dart';
import 'package:aqarak/presentation/cubits/auth/auth_cubit.dart';
import 'package:aqarak/presentation/cubits/splash/splash_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Aqarak());
}

class Aqarak extends StatelessWidget {
  const Aqarak({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize AuthRepository and Use Cases
    final authRemoteDataSource = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final signUp = SignUp(repository: authRepository);
    final signIn = SignIn(repository: authRepository);
    final verifyOTP = VerifyOTP(repository: authRepository);
    final resetPassword = ResetPassword(repository: authRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashCubit()),
        BlocProvider(
          create: (_) => AuthCubit(
            signUp: signUp,
            signIn: signIn,
            verifyOTP: verifyOTP,
            resetPassword: resetPassword,
            router: AppRouter.router,
          ),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
