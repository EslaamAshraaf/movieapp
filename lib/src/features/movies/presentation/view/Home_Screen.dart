import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/src/features/movies/presentation/view/BrowseScreen.dart';
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
      create: (_) => HomeViewModel()..getMovies(),
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

                    /// 🔹 CarouselSlider
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                      ),
                      items: movies.take(5).map((movie) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Moviedetails(movieId: movie.id!),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              movie.largeCoverImage ?? "",
                              fit: BoxFit.cover,
                            ),
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

                    /// 🔹 Categories Sections
                    buildCategorySection("Action", movies, context),
                    buildCategorySection("Drama", movies, context),
                    buildCategorySection("Horror", movies, context),
                    buildCategorySection("Comedy", movies, context),
                    buildCategorySection("Sci-Fi", movies, context),

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

  /// 🔹 ويدجت للقسم بالكامل
  Widget buildCategorySection(String title, List<Movies> movies, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCategoryRow(title, context),
        buildMovieList(
          movies.where((m) => m.genres?.contains(title) ?? false).toList(),
          context,
        ),
      ],
    );
  }

  /// 🔹 العنوان مع زر See More
  Widget buildCategoryRow(String title, BuildContext context) {
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Browse(initialCategory: title),
                ),
              );
            },
            child: const Text(
              "See More →",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 قائمة الأفلام
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
                  builder: (_) => Moviedetails(movieId: movie.id!),
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
