import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movieapp/src/features/movies/presentation/view/MainLayout.dart';
import 'package:movieapp/src/features/onboarding/presentation/views/view_Main.dart';
import 'package:movieapp/src/features/splash/splash.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/src/core/firebase/firebase_options.dart';
import 'package:movieapp/src/features/Profile/presentation/viewmodels/Editprofile_viewModel.dart';
import 'package:movieapp/src/core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserViewModel()..loadUserData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: SplashScreen.RouteName,
      ),
    );
  }
}
