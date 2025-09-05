class MovieItem {
  final int id;
  final String title;
  final String year;
  final String? mediumCoverImage;

  MovieItem({
    required this.id,
    required this.title,
    required this.year,
    this.mediumCoverImage,
  });

  factory MovieItem.fromJson(Map<String, dynamic> json) {
    return MovieItem(
      id: json['id'],
      title: json['title'] ?? '',
      year: json['year']?.toString() ?? '',
      mediumCoverImage: json['medium_cover_image'],
    );
  }
}

class MovieListResponse {
  final List<MovieItem> movies;

  MovieListResponse({required this.movies});

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    final moviesJson = json['data']?['movies'] as List? ?? [];
    return MovieListResponse(
      movies: moviesJson.map((e) => MovieItem.fromJson(e)).toList(),
    );
  }
}
