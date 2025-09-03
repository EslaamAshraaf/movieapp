import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/src/core/theme/app_color.dart';
import '../../../../core/theme/widgets/app_text_form_field.dart';

class Forgotpassword extends StatefulWidget {
  static const String routename = "forgot_password";
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<Forgotpassword> {
  final TextEditingController _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr("enter_email"))),
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr("reset_link_sent")),
          backgroundColor: Colors.green,
        ),
      );

      // رجع المستخدم لشاشة تسجيل الدخول بعد ثانيتين
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "user-not-found") {
        message = tr("user_not_found");
      } else {
        message = e.message ?? tr("error_occurred");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          tr("forget_password"),
          style: TextStyle(color: AppColors.yellow, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/forgotpassword.png"),
            const SizedBox(height: 24),

            AppTextFormField(
              controller: _emailController,
              label: tr("email"),
              hintText: tr("enter_email"),
              iconPath: "assets/icons/email.png",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),

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
                onPressed: _resetPassword,
                child: Text(
                  tr("verify_email"),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
