import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/MovieDetailsViewModel.dart';

class Moviedetails extends StatelessWidget {
  static const String routename = "Moviedetails";
  final int movieId;

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

          return Scaffold(
            backgroundColor: Colors.black,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.black,
                  expandedHeight: 400,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          movie.largeCoverImage != null && movie.largeCoverImage!.isNotEmpty
                              ? movie.largeCoverImage!
                              : "https://via.placeholder.com/300x400.png?text=No+Image",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset("assets/images/placeholder.png", fit: BoxFit.cover),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black],
                              stops: [0.25, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          movie.title ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatItem(Icons.favorite, "${movie.likeCount ?? 0}"),
                          _buildStatItem(Icons.schedule, "${movie.runtime ?? ''} min"),
                          _buildStatItem(Icons.star, "${movie.rating ?? ''}"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildSectionTitle("Screen Shots"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            if (movie.mediumScreenshotImage1 != null && movie.mediumScreenshotImage1!.isNotEmpty)
                              _buildScreenshot(movie.mediumScreenshotImage1!),
                            if (movie.mediumScreenshotImage2 != null && movie.mediumScreenshotImage2!.isNotEmpty)
                              _buildScreenshot(movie.mediumScreenshotImage2!),
                            if (movie.mediumScreenshotImage3 != null && movie.mediumScreenshotImage3!.isNotEmpty)
                              _buildScreenshot(movie.mediumScreenshotImage3!),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildSectionTitle("Similar"),
                      vm.suggestions.isEmpty
                          ? const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "No similar movies found",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                          : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: vm.suggestions.length,
                        itemBuilder: (_, index) {
                          final suggestion = vm.suggestions[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    suggestion.mediumCoverImage != null && suggestion.mediumCoverImage!.isNotEmpty
                                        ? suggestion.mediumCoverImage!
                                        : "https://via.placeholder.com/200x300.png?text=No+Image",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset("assets/images/placeholder.png", fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                suggestion.title ?? "",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // ✅ Summary + Description
                      _buildSectionTitle("Summary"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          (movie.descriptionFull?.isNotEmpty == true)
                              ? movie.descriptionFull!
                              : (movie.summary?.isNotEmpty == true)
                              ? movie.summary!
                              : (movie.descriptionIntro?.isNotEmpty == true)
                              ? movie.descriptionIntro!
                              : "No summary available",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),

                      _buildSectionTitle("Cast"),
                      Column(
                        children: movie.cast?.map((actor) {
                          return _buildCastTile(
                            imageUrl: actor.urlSmallImage ?? "",
                            name: actor.name ?? "Unknown",
                            character: actor.characterName ?? "",
                          );
                        }).toList() ??
                            [],
                      ),
                      const SizedBox(height: 20),

                      _buildSectionTitle("Genres"),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: movie.genres
                            ?.map((genre) => Chip(
                          backgroundColor: Colors.red,
                          label: Text(
                            genre,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ))
                            .toList() ??
                            [],
                      ),
                      const SizedBox(height: 30),
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

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.red, size: 20),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildScreenshot(String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url.isNotEmpty ? url : "https://via.placeholder.com/300x200.png?text=No+Image",
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          errorBuilder: (context, error, stackTrace) =>
              Image.asset("assets/images/placeholder.png", fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _buildCastTile({
    required String imageUrl,
    required String name,
    required String character,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: imageUrl.isNotEmpty
            ? NetworkImage(imageUrl)
            : const AssetImage("assets/images/avatar.png") as ImageProvider,
        backgroundColor: Colors.grey,
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        character,
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
