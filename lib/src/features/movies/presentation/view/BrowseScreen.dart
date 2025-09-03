import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  static const routeName = "browse";
  const Browse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    categoryChip("Action", true),
                    SizedBox(width: 8),
                    categoryChip("Adventure", false),
                    SizedBox(width: 8),
                    categoryChip("Animation", false),
                    SizedBox(width: 8),
                    categoryChip("Biography", false),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return movieCard(
                      movies[index]["image"]!,
                      movies[index]["rating"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget movieCard(String image, String rating) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.asset(image, fit: BoxFit.cover, width: double.infinity),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rating,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.yellow, size: 14),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryChip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: selected ? Color(0xFFF6BD00) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFF6BD00), width: 2),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.black : Color(0xFFF6BD00),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

final List<Map<String, String>> movies = [
  {"image": "assets/images/Blzk.png", "rating": "7.7"},
  {"image": "assets/images/joker.png", "rating": "8.5"},
  {"image": "assets/images/ironman.png", "rating": "7.9"},
  {"image": "assets/images/war.png", "rating": "8.0"},
  {"image": "assets/images/avenger.png", "rating": "8.2"},
  {"image": "assets/images/doctor.png", "rating": "7.6"},
];