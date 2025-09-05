import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/Models/MovieListModel.dart';
import '../../data/models/MovieDetailsModel.dart';

class MovieDetailsViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  Movie? movie;
  List<Movies> suggestions = [];

  Future<void> getMovieDetails(int movieId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final url = Uri.parse(
          "https://yts.mx/api/v2/movie_details.json?movie_id=$movieId&with_images=true&with_cast=true");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        movie = MovieDetailsModel.fromJson(data).data?.movie;
      } else {
        errorMessage = "Failed to load details";
      }

      final sugUrl = Uri.parse(
          "https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieId");
      final sugResponse = await http.get(sugUrl);

      if (sugResponse.statusCode == 200) {
        final sugData = jsonDecode(sugResponse.body);
        final List moviesJson = sugData["data"]["movies"];
        suggestions = moviesJson.map((e) => Movies.fromJson(e)).toList();
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}