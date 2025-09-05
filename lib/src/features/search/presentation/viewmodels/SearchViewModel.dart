import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/ModelMovieListResponse.dart';


class SearchViewModel extends ChangeNotifier {
  final List<MovieItem> _movies = [];
  List<MovieItem> get movies => _movies;

  bool isLoading = false;
  bool hasError = false;
  bool hasMore = true;

  int _page = 1;
  String _query = '';
  Timer? _debounce;

  void onQueryChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _query = query;
      _page = 1;
      _movies.clear();
      hasMore = true;
      fetchMovies();
    });
  }

  Future<void> fetchMovies() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final url = Uri.parse(
        "https://yts.mx/api/v2/list_movies.json?limit=20&page=$_page&query_term=$_query",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final result = MovieListResponse.fromJson(jsonData);

        if (result.movies.isEmpty) {
          hasMore = false;
        } else {
          _movies.addAll(result.movies);
          _page++;
        }
      } else {
        hasError = true;
      }
    } catch (e) {
      hasError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshMovies() async {
    _page = 1;
    _movies.clear();
    hasMore = true;
    await fetchMovies();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
