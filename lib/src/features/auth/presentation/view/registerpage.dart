import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/theme/app_color.dart';
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
        child: Image.asset(
          asset,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

class Registerpage extends StatefulWidget {
  static const String routename = "registerpage";
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.black,
        title: Text(
          tr("create_one"), // You can replace with "Register" if needed
          style: TextStyle(color: AppColors.yellow),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(child: Image.asset("assets/avatar.png")),
              const SizedBox(height: 10),
              Text(tr("create_one"),
                  style: TextStyle(color: AppColors.white, fontSize: 19)),
              const SizedBox(height: 20),
              AppTextFormField(
                label: tr("name"),
                hintText: tr("enter_email"),
                iconPath: "assets/icons/person.png",
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
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
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  icon: Icon(
                      _obscurePassword
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: AppColors.yellow),
                ),
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                label: tr("confirm_password"),
                hintText: tr("enter_password"),
                iconPath: "assets/icons/lock.png",
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  icon: Icon(
                      _obscureConfirmPassword
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      color: AppColors.yellow),
                ),
              ),
              const SizedBox(height: 20),
              AppTextFormField(
                label: tr("phone"),
                iconPath: "assets/icons/phone.png",
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
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
                  child: Text(
                    tr("Create Account"),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100  ,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.yellow, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
