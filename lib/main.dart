import 'dart:developer';

import 'package:aqarak/app_router.dart';
import 'package:aqarak/core/constants/app_strings.dart';
import 'package:aqarak/core/constants/app_themes.dart';
import 'package:aqarak/data/datasources/auth_remote_datasource.dart';
import 'package:aqarak/data/datasources/loca_datassources/place_local_datastore.dart';
import 'package:aqarak/data/models/place_model_adapter.dart';
import 'package:aqarak/data/repositories/auth_repository_impl.dart';
import 'package:aqarak/domain/usecases/reset_password.dart';
import 'package:aqarak/domain/usecases/sign_in.dart';
import 'package:aqarak/domain/usecases/sign_up.dart';
import 'package:aqarak/domain/usecases/verify_otp.dart';
import 'package:aqarak/presentation/cubits/auth/auth_cubit.dart';
import 'package:aqarak/presentation/cubits/splash/splash_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.playIntegrity,
    );
    await GoogleSignIn.instance.initialize(
      serverClientId:
          '204029371189-lo1llb38dmouqfska98ioiudtpqhactt.apps.googleusercontent.com',
    );
    await Hive.initFlutter();
    Hive.registerAdapter(PlaceModelAdapter());
    await PlaceLocalDataSource().init();
    runApp(const Aqarak());
  } catch (e) {
    log('Initialization error: $e');
  }
}

class Aqarak extends StatelessWidget {
  const Aqarak({super.key});

  @override
  Widget build(BuildContext context) {
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
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
