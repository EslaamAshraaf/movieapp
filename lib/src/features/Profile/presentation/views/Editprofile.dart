import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_color.dart';
import '../viewmodels/Editprofile_viewModel.dart';


class EditProfile extends StatelessWidget {
  static const String routename = "Editprofile";

  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.yellow),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Pick Avatar", style: TextStyle(color: AppColors.yellow)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // اختيار صورة جديدة
                vm.updateAvatar("assets/Profiles/profile2.png");
              },
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(vm.user.avatar),
                backgroundColor: AppColors.darkGray,
              ),
            ),
            const SizedBox(height: 30),

            TextField(
              style: const TextStyle(color: AppColors.white),
              onChanged: vm.updateName,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: AppColors.white),
                hintText: vm.user.name,
                hintStyle: const TextStyle(color: AppColors.white),
                filled: true,
                fillColor: AppColors.darkGray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: AppColors.white),
              onChanged: vm.updatePhone,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, color: AppColors.white),
                hintText: vm.user.phone,
                hintStyle: const TextStyle(color: AppColors.white),
                filled: true,
                fillColor: AppColors.darkGray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
