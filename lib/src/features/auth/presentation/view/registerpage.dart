import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/firebase/firbase_manager.dart';
import 'package:movieapp/src/core/theme/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieapp/src/features/movies/presentation/view/MainLayout.dart';
import '../../../../core/theme/widgets/app_text_form_field.dart';

class Registerpage extends StatefulWidget {
  static const String routename = "registerpage";
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  // controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseManager manager = FirebaseManager();

  Future<void> _registerUser() async {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // إنشاء الحساب
      UserCredential? userCred = await manager.createUserWithEmailAndPassword(
        emailAddress: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (userCred != null && userCred.user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCred.user!.uid)
            .set({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        });

        // ✅ التنقل للـ Home بعد النجاح
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainLayout()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.black,
        title: Text(
          tr("create_one"),
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
              Center(child: Image.asset("assets/images/avatar.png")),
              const SizedBox(height: 10),
              Text(
                tr("create_one"),
                style: TextStyle(color: AppColors.white, fontSize: 19),
              ),
              const SizedBox(height: 20),

              // Name
              AppTextFormField(
                label: tr("name"),
                hintText: tr("enter_name"),
                iconPath: "assets/icons/person.png",
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              const SizedBox(height: 20),

              // Email
              AppTextFormField(
                label: tr("email"),
                hintText: tr("enter_email"),
                iconPath: "assets/icons/email.png",
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 20),

              // Password
              AppTextFormField(
                label: tr("password"),
                hintText: tr("enter_password"),
                iconPath: "assets/icons/lock.png",
                obscureText: _obscurePassword,
                controller: passwordController,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: AppColors.yellow,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Confirm Password
              AppTextFormField(
                label: tr("confirm_password"),
                hintText: tr("enter_password"),
                iconPath: "assets/icons/lock.png",
                obscureText: _obscureConfirmPassword,
                controller: confirmPasswordController,
                suffixIcon: IconButton(
                  onPressed: () => setState(() =>
                  _obscureConfirmPassword = !_obscureConfirmPassword),
                  icon: Icon(
                    _obscureConfirmPassword
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye,
                    color: AppColors.yellow,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Phone
              AppTextFormField(
                label: tr("phone"),
                iconPath: "assets/icons/phone.png",
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 20),

              // Register button
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
                  onPressed: _isLoading ? null : _registerUser,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Text(
                    tr("create_account"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
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