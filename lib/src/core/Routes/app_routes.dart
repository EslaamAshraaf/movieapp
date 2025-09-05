import 'package:flutter/material.dart';
import 'package:movieapp/src/features/movies/presentation/view/Moviedetails.dart';
import 'package:movieapp/src/features/Profile/presentation/views/Editprofile.dart';
import 'package:movieapp/src/features/Profile/presentation/views/ProfileScreen.dart';
import 'package:movieapp/src/features/auth/presentation/view/Forgotpassword.dart';
import 'package:movieapp/src/features/auth/presentation/view/loginpage.dart';
import 'package:movieapp/src/features/auth/presentation/view/registerpage.dart';
import 'package:movieapp/src/features/movies/presentation/view/BrowseScreen.dart';
import 'package:movieapp/src/features/movies/presentation/view/MainLayout.dart';
import 'package:movieapp/src/features/search/presentation/views/SearchScreen.dart';
import 'package:movieapp/src/features/onboarding/presentation/views/view_Main.dart';
import 'package:movieapp/src/features/onboarding/presentation/views/view.dart';

import '../../features/splash/splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    SplashScreen.RouteName: (_)=> SplashScreen(),
    Onboardingmain.routename: (_) => Onboardingmain(),
    Onboarding.routename: (_) => Onboarding(),
    LoginPage.routename: (_) => LoginPage(),
    Registerpage.routename: (_) => Registerpage(),
    Forgotpassword.routename: (_) => Forgotpassword(),
    MainLayout.routename: (_) => MainLayout(),
    SearchScreen.routename: (_) => SearchScreen(),
    Browse.routeName: (_) => Browse(initialCategory: ''),
    Profile.routeName: (_) => Profile(),
    Editprofile.routename: (_) => Editprofile(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Moviedetails.routename) {
      final movieId = settings.arguments as int;
      return MaterialPageRoute(
        builder: (_) => Moviedetails(movieId: movieId),
      );
    }
    return null;
  }
}
