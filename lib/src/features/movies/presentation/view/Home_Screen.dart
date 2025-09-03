import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../data/Models/MovieListModel.dart';
import '../viewmodels/HomeViewModel.dart';
import 'Moviedetails.dart';


class HomeScreen extends StatelessWidget {
  static const String routename = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel()..getMovies(), // استدعاء API عند فتح الصفحة
      child: Consumer<HomeViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text(vm.errorMessage!));
          }

          final movies = vm.movies;

          return Stack(
            children: [
              /// الخلفية
              if (movies.isNotEmpty)
                Positioned.fill(
                  child: Image.network(
                    movies.first.largeCoverImage ?? "",
                    fit: BoxFit.cover,
                  ),
                ),

              /// overlay
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
                    /// Banner "Available Now"
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.asset(
                        "assets/images/Available Now.png",
                        width: double.infinity,
                        alignment: Alignment.topCenter,
                      ),
                    ),

                    /// 🔹 CarouselSlider من الـ movies
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: movies.take(5).map((movie) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            movie.largeCoverImage ?? "",
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    /// Watch Now banner
                    Image.asset(
                      "assets/images/Watch Now.png",
                      width: double.infinity,
                    ),

                    /// مثال قسم الأكشن (هيعرض الأفلام اللي Genre = Action)
                    buildCategoryRow("Action"),
                    buildMovieList(
                      movies.where((m) => m.genres?.contains("Action") ?? false).toList(),
                      context,
                    ),

                    /// قسم Adventure
                    buildCategoryRow("Drama"),
                    buildMovieList(
                      movies.where((m) => m.genres?.contains("Drama") ?? false).toList(),
                      context,
                    ),

                    /// قسم Animation
                    buildCategoryRow("Horror"),
                    buildMovieList(
                      movies.where((m) => m.genres?.contains("Horror") ?? false).toList(),
                      context,
                    ),

                    /// قسم Biography
                    buildCategoryRow("Comedy"),
                    buildMovieList(
                      movies.where((m) => m.genres?.contains("Comedy") ?? false).toList(),
                      context,
                    ),
                    buildCategoryRow("Sci-Fi"),
                    buildMovieList(
                      movies.where((m) => m.genres?.contains("Sci-Fi") ?? false).toList(),
                      context,
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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

  /// 🔹 ويدجت لقائمة الأفلام
  Widget buildMovieList(List<Movies> movies, BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: movies.map((movie) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Moviedetails(movieId: movie.id!), // 👈 إرسال الـ id
                ),
              );
            },
            child: Container(
              width: 140,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(movie.mediumCoverImage ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

}
