import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/MovieDetailsModel.dart';
import '../Models/MovieListModel.dart';

class MovieRepository {
  static const String baseUrl = "https://yts.mx/api/v2";


  Future<MovieListModel> fetchMovies() async {
    final url = Uri.parse("$baseUrl/list_movies.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // هنا بيرجع Object من نوع MovieListModel
      return MovieListModel.fromJson(data);
    } else {
      throw Exception("Failed to load movies");
    }
  }

  /// Fetch movie details by movie id
  Future<MovieDetailsModel> fetchMovieDetails(int movieId) async {
    final url = Uri.parse(  "https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_cast=true&with_images=true");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MovieDetailsModel.fromJson(jsonData);
    } else {
      throw Exception("Failed to load movie details");
    }
  }



  /// Fetch movie suggestions by movie id
  Future<List<Movies>> fetchMovieSuggestions(int movieId) async {
    final url = Uri.parse("$baseUrl/movie_suggestions.json?movie_id=$movieId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final movies = (data["data"]["movies"] as List)
          .map((json) => Movies.fromJson(json))
          .toList();
      return movies;
    } else {
      throw Exception("Failed to load movie suggestions");
    }
  }


}
