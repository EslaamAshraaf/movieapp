import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movieapp/src/core/theme/app_color.dart';
import 'package:movieapp/src/features/auth/presentation/view/Forgotpassword.dart';
import 'package:movieapp/src/features/auth/presentation/view/registerpage.dart';
import 'package:movieapp/src/features/movies/presentation/view/Moviedetails.dart';
import '../../../../core/theme/widgets/app_text_form_field.dart';

Widget _buildFlag({
  required String asset,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: AppColors.yellow, width: 2)
            : null,
      ),
      child: ClipOval(
        child: Image.asset(asset, width: 32, height: 32, fit: BoxFit.cover),
      ),
    ),
  );
}

class Loginpage extends StatelessWidget {
  static const String routename = "loginpage";
  const Loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            children: [
              const SizedBox(height: 77),
              Center(child: Image.asset("assets/splash.png")),
              const SizedBox(height: 70),

              AppTextFormField(
                label: tr("email"),
                hintText: tr("enter_email"),
                iconPath: "assets/icons/email.png",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              AppTextFormField(
                label: tr("password"),
                hintText: tr("enter_password"),
                iconPath: "assets/icons/lock.png",
                obscureText: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.eye_slash, color: AppColors.yellow),
                ),
              ),
              const SizedBox(height: 17),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Forgotpassword.routename);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    tr("forget_password"),
                    style: TextStyle(color: AppColors.yellow, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 33),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Moviedetails.routename);
                  },
                  child: Text(
                    tr("login"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              // Create Account
              Text.rich(
                TextSpan(
                  text: "${tr("dont_have_account")} ",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                  children: [
                    TextSpan(
                      text: tr("create_one"),
                      style: const TextStyle(
                        color: AppColors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Registerpage.routename);
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 27),

              // Divider with OR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.yellow,
                        thickness: 1,
                        endIndent: 10,
                      ),
                    ),
                    Text(
                      tr("or"),
                      style: const TextStyle(
                        color: AppColors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.yellow,
                        thickness: 1,
                        indent: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Google Login
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ImageIcon(
                        AssetImage("assets/icons/google.png"),
                        size: 26,
                        color: Color(0xff282A28),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "login_google".tr(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 33),
              Container(
                width: 100,
                child: Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.yellow, width: 2),
                    ),
                    child: Row(
                      children: [
                        _buildFlag(
                          asset: "assets/icons/usa.png",
                          isSelected: currentLocale == "en",
                          onTap: () => context.setLocale(const Locale('en')),
                        ),
                        const SizedBox(width: 12),
                        _buildFlag(
                          asset: "assets/icons/EG.png",
                          isSelected: currentLocale == "ar",
                          onTap: () => context.setLocale(const Locale('ar')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
