import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../movies/presentation/view/Moviedetails.dart';
import '../../data/ModelMovieListResponse.dart';
import '../viewmodels/SearchViewModel.dart';

class SearchScreen extends StatelessWidget {
  static const routename = "search";

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      child: Scaffold(
        backgroundColor: const Color(0xFF121312),
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, _) => TextField(
                    style: const TextStyle(color: Colors.white),
                    onChanged: viewModel.onQueryChanged,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      hintText: "Search",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 8,
                      ),
                      fillColor: const Color(0xFF282A28),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<SearchViewModel>(
                builder: (context, viewModel, _) {
                  if (viewModel.isLoading && viewModel.movies.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (viewModel.hasError) {
                    return const Center(
                      child: Text("Error loading movies",
                          style: TextStyle(color: Colors.white)),
                    );
                  }

                  if (viewModel.movies.isEmpty) {
                    return Center(
                      child: Image.asset("assets/images/Empty 1.png"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: viewModel.refreshMovies,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollInfo) {
                        if (!viewModel.isLoading &&
                            viewModel.hasMore &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 200) {
                          viewModel.fetchMovies();
                        }
                        return false;
                      },
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: viewModel.movies.length,
                        itemBuilder: (context, index) {
                          final movie = viewModel.movies[index];
                          return _buildMovieCard(context, movie);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, MovieItem movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Moviedetails(movieId: movie.id),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          movie.mediumCoverImage ??
              "https://via.placeholder.com/200x300.png?text=No+Image",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[800],
            child: const Icon(Icons.broken_image, color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
