import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movieapp/src/features/Profile/presentation/viewmodels/Editprofile_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/src/features/Profile/presentation/views/Editprofile.dart';
import 'package:movieapp/src/features/auth/presentation/view/Forgotpassword.dart';
import 'package:movieapp/src/features/auth/presentation/view/loginpage.dart';
import 'package:movieapp/src/features/auth/presentation/view/registerpage.dart';
import 'package:movieapp/src/features/movies/presentation/view/BrowseScreen.dart';
import 'package:movieapp/src/features/movies/presentation/view/MainLayout.dart';
import 'package:movieapp/src/features/movies/presentation/view/Moviedetails.dart';
import 'package:movieapp/src/features/Profile/presentation/views/ProfileScreen.dart';
import 'package:movieapp/src/features/search/presentation/views/SearchScreen.dart';
import 'package:movieapp/src/features/onboarding/presentation/views/view_Main.dart';
import 'src/core/firebase/firebase_options.dart';
import 'src/features/onboarding/presentation/views/view.dart';

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
          create: (_) => UserViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routes: {
          Onboardingmain.routename: (_) => Onboardingmain(),
          Onboarding.routename: (_) => Onboarding(),
          LoginPage.routename: (_) => LoginPage(),
          Registerpage.routename: (_) => Registerpage(),
          Forgotpassword.routename: (_) => Forgotpassword(),
          MainLayout.routename: (_) => MainLayout(),
          Search.routename: (_) => Search(),
          Browse.routeName: (_) => Browse(),
          Profile.routeName: (_) => Profile(),
          EditProfile.routename: (_) => EditProfile(),
        },

        initialRoute: Onboardingmain.routename,
      ),

    );
  }
}
