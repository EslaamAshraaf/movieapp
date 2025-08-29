import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  static const String routename = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> bannerImages = [
      "assets/images/1917.png",
      "assets/images/Captain.png",
      "assets/images/baby.png",
    ];

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset("assets/images/1917.png", fit: BoxFit.cover),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),

        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/images/Available Now.png",
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                ),
              ),


              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: bannerImages.map((imagePath) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              /// Watch Now banner
              Image.asset(
                "assets/images/Watch Now.png",
                width: double.infinity,
              ),

              /// قسم الأكشن
              buildCategoryRow("Action"),
              buildMovieList([
                "assets/images/captain_small.png",
                "assets/images/batMan.png",
                "assets/images/black_woman.png",
              ]),

              /// قسم Adventure
              buildCategoryRow("Adventure"),
              buildMovieList([
                "assets/images/captain_small.png",
                "assets/images/batMan.png",
                "assets/images/black_woman.png",
              ]),

              /// قسم Animation
              buildCategoryRow("Animation"),
              buildMovieList([
                "assets/images/captain_small.png",
                "assets/images/batMan.png",
                "assets/images/black_woman.png",
              ]),

              /// قسم Biography
              buildCategoryRow("Biography"),
              buildMovieList([
                "assets/images/captain_small.png",
                "assets/images/batMan.png",
                "assets/images/black_woman.png",
              ]),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 ويدجت للعنوان
  Widget buildCategoryRow(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "See More →",
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMovieList(List<String> images) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: images.map((img) {
          return Container(
            width: 140,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            ),
          );
        }).toList(),
      ),
    );
  }
}
