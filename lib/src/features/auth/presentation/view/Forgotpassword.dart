import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/theme/app_color.dart';

import '../../../../core/theme/widgets/app_text_form_field.dart';

class Forgotpassword extends StatelessWidget {
  static const String routename = "forgotpassword";
  const Forgotpassword({super.key});

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
          "Forget Password",
          style: TextStyle(color: AppColors.yellow, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Image.asset("assets/images/forgotpassword.png"),
            const SizedBox(height: 24),

            AppTextFormField(
              label: tr("email"),
              hintText: tr("enter_email"),
              iconPath: "assets/icons/email.png",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),

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
                onPressed: () {},
                child: Text(
                  tr("Verify Email"),
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
