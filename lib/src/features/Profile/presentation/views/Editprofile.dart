import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/theme/app_color.dart';

class Editprofile extends StatefulWidget {
  static const routename = "Editprofile";
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => EditprofileState();
}

class EditprofileState extends State<Editprofile> {
  String selectedAvatar = "assets/Profiles/profile1.png";
  final List<String> avatars = List.generate(
    9,
        (index) => "assets/Profiles/profile${index + 1}.png",
  );

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
    await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _nameController.text = data["name"] ?? "";
        _phoneController.text = data["phone"] ?? "";
        selectedAvatar = data["avatar"] ?? selectedAvatar;
      });
    }
  }

  Future<void> _updateProfile() async {
    Navigator.pop(context);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("users").doc(uid).update({
      "name": _nameController.text.trim(),
      "phone": _phoneController.text.trim(),
      "avatar": selectedAvatar,
    });
  }

  void _pickAvatar() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final avatar = avatars[index];
              final isSelected = avatar == selectedAvatar;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatar;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.yellow : AppColors.darkGray,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(avatar, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: const Text("Edit Profile", style: TextStyle(color: AppColors.yellow)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAvatar,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(selectedAvatar),
              ),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person, color: AppColors.white),
                hintText: "Name",
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
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: AppColors.white),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.phone, color: AppColors.white),
                hintText: "Phone",
                hintStyle: const TextStyle(color: AppColors.white),
                filled: true,
                fillColor: AppColors.darkGray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _updateProfile ,
                child: const Text(
                  "Update Data",
                  style: TextStyle(fontSize: 16, color: AppColors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
