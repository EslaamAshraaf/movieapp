import 'package:flutter/material.dart';
import 'package:movieapp/src/features/movies/presentation/view/Moviedetails.dart';
import 'package:provider/provider.dart';
import '../viewmodels/BrowseViewModel.dart';
import '../../data/Models/MovieListModel.dart';

class Browse extends StatelessWidget {
  static const routeName = "browse";
  const Browse({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BrowseViewModel()..getMovies(), // 👈 id افتراضي
      child: Consumer<BrowseViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text(vm.errorMessage!));
          }

          final movies = vm.movies;

          return Scaffold(
            backgroundColor: const Color(0xFF121312),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 Categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          categoryChip("Action", vm),
                          const SizedBox(width: 8),
                          categoryChip("Drama", vm),
                          const SizedBox(width: 8),
                          categoryChip("Horror", vm),
                          const SizedBox(width: 8),
                          categoryChip("Comedy", vm),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// 🔹 Movies Grid
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
                          final movie = movies[index];
                          return movieCard(context, movie);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Movie Card
  Widget movieCard(BuildContext context, Movies movie) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Moviedetails.routename, // 👈 route بتاع صفحة التفاصيل
          arguments: movie.id, // 👈 مررنا الـ movieId
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.network(
              movie.mediumCoverImage ?? "",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
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
                      "${movie.rating ?? 0}",
                      style: const TextStyle(
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
      ),
    );
  }

  /// 🔹 Category Chip
  Widget categoryChip(String text, BrowseViewModel vm) {
    final selected = vm.selectedCategory == text;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFF6BD00) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF6BD00), width: 2),
      ),
      child: TextButton(
        onPressed: () => vm.changeCategory(text),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.black : const Color(0xFFF6BD00),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
