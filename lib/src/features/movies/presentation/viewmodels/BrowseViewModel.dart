import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../data/Models/MovieListModel.dart';

class BrowseViewModel extends ChangeNotifier {
  List<Movies> allMovies = [];
  List<Movies> movies = [];
  bool isLoading = false;
  String? errorMessage;
  String selectedCategory = "Action";

  Future<void> getMovies() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final url = Uri.parse("https://yts.mx/api/v2/list_movies.json");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List moviesJson = data["data"]["movies"] ?? [];
        allMovies = moviesJson.map((e) => Movies.fromJson(e)).toList();

        filterMoviesByCategory();
      } else {
        errorMessage = "Failed to load movies";
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void changeCategory(String category) {
    selectedCategory = category;
    filterMoviesByCategory();
    notifyListeners();
  }

  void filterMoviesByCategory() {
    movies = allMovies
        .where((m) => m.genres?.contains(selectedCategory) ?? false)
        .toList();
  }
}
