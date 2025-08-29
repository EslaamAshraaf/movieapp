import 'package:flutter/material.dart';
import 'package:movieapp/src/features/Profile/presentation/views/ProfileScreen.dart';
import 'package:movieapp/src/features/movies/presentation/view/BrowseScreen.dart';
import 'package:movieapp/src/features/search/presentation/views/SearchScreen.dart';

import 'Home_Screen.dart';

class MainLayout extends StatefulWidget {
  static const String routename = "MainLayout";

  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> pages = [HomeScreen(), Search(), Browse(), Profile()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF282A28),
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/home.png")),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/search.png")),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/browse.png")),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/profile.png")),
            label: "",
          ),
        ],
      ),
      body: pages[currentIndex],
    );
  }
}
