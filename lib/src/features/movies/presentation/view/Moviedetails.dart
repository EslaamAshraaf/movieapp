import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_color.dart';
import '../viewmodels/MovieDetailsViewModel.dart';


class Moviedetails extends StatelessWidget {
  static const String routename = "Moviedetails";
  final int movieId; // 👈 هنستقبل id بتاع الفيلم

  const Moviedetails({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel()..getMovieDetails(movieId),
      child: Consumer<MovieDetailsViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(color: Colors.red),
              ),
            );
          }

          if (vm.errorMessage != null) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  vm.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          final movie = vm.movie;
          if (movie == null) {
            return const Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Text(
                  "No movie details available",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }

          // 🔥 هنا هنرجع نفس التصميم بتاعك بالـ Data الحقيقية
          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                // Background Image (Movie Poster)
                Positioned.fill(
                  child: Image.network(
                    movie.largeCoverImage ?? "",
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),

                // Scrollable content
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 500),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Movie Title
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            movie.title ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Watch Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              minimumSize: const Size(double.infinity, 58),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Watch",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Stats Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatItem("${movie.year ?? ''}"),
                            _buildStatItem("${movie.runtime ?? ''} min"),
                            _buildStatItem("${movie.rating ?? ''}"),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            movie.descriptionFull ?? "",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // Top Bar (Back + Bookmark)
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: AppColors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark,
                          size: 30,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper widget for stats
  Widget _buildStatItem(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
