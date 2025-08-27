import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movieapp/src/features/auth/presentation/view/Forgotpassword.dart';
import 'package:movieapp/src/features/auth/presentation/view/loginpage.dart';
import 'package:movieapp/src/features/auth/presentation/view/registerpage.dart';
import 'package:movieapp/src/features/movies/presentation/view/Homescreen.dart';
import 'package:movieapp/src/features/movies/presentation/view/Moviedetails.dart';
import 'package:movieapp/src/features/onboarding/presentation/views/view_Main.dart';
import 'src/features/onboarding/presentation/views/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales:[
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // add localization delegates
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      routes: {
        Onboardingmain.routename: (_) => Onboardingmain(),
        Onboarding.routename: (_) => Onboarding(),
        Loginpage.routename: (_) => Loginpage(),
        Registerpage.routename:(_)=>Registerpage(),
        Forgotpassword.routename:(_)=>Forgotpassword(),
        Homescreen.routename:(_)=>Homescreen(),
        Moviedetails.routename:(_)=>Moviedetails(),
      },
      initialRoute: Homescreen.routename,
    );
  }
}
