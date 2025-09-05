import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/theme/app_color.dart';
import 'package:movieapp/src/features/onboarding/presentation/views/view_Main.dart';


class SplashScreen extends StatefulWidget {
  static const String RouteName = "splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait for 3 seconds then navigate
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboardingmain()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Logo image
          Center(
            child: Image.asset(
              "assets/images/splash.png",
              width: 120,
              height: 120,
            ),
          ),
          const Spacer(),
          // Route image
          Image.asset(
            "assets/images/Route.png",
            height: 40,
          ),
          const SizedBox(height: 8),
          // Supervised by text
          const Text(
            "Supervised by Mohamed Nabil",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}