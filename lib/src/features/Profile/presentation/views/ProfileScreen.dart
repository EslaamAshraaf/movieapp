import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/theme/app_color.dart';
import 'package:movieapp/src/features/Profile/presentation/views/Editprofile.dart';
import 'package:movieapp/src/features/auth/presentation/view/loginpage.dart';

class Profile extends StatelessWidget {
  static const String routeName = "Profile";

  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            backgroundColor: AppColors.black,
            body: const Center(
              child: Text(
                "No profile data found",
                style: TextStyle(color: AppColors.white, fontSize: 20),
              ),
            ),
          );
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: const Color(0xFF121312),
            body: Column(
              children: [
                Flexible(
                  flex: 0,
                  child: Container(
                    color: const Color(0xFF212121),
                    child: SafeArea(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // Avatar + Counters
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(
                                  userData['avatar'] ??
                                      "assets/Profiles/profile1.png",
                                ),
                                backgroundColor: AppColors.darkGray,
                              ),
                              Text(
                                "12",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "10",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // Name + Labels
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                userData['name'] ?? "No Name",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Wish List",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "History",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),

                          // Buttons (Edit + Exit)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: AppColors.yellow,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Editprofile.routename);
                                    },
                                    child: const Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        color: Color(0xFF121312),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: AppColors.red,
                                    ),
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacementNamed(context, LoginPage.routename);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Exit",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(Icons.exit_to_app,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Tabs
                          const TabBar(
                            unselectedLabelColor: Colors.yellow,
                            indicatorColor: Colors.yellow,
                            indicatorWeight: 4,
                            dividerColor: Color(0xFF202020),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.white,
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            tabs: [
                              Tab(
                                icon: Icon(Icons.list,
                                    color: Colors.yellow, size: 35),
                                text: "Watch List",
                              ),
                              Tab(
                                icon: Icon(Icons.folder,
                                    color: Colors.yellow, size: 35),
                                text: "History",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ================= BODY =================
                Expanded(
                  child: Container(
                    color: const Color(0xFF121312),
                    child: const TabBarView(
                      children: [
                        Center(
                          child:
                          Image(image: AssetImage("assets/images/Empty 1.png")),
                        ),
                        Center(
                          child:
                          Image(image: AssetImage("assets/images/Empty 1.png")),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
