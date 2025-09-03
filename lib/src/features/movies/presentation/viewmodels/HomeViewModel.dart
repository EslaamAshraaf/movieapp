import 'package:flutter/material.dart';

import '../../data/Models/MovieListModel.dart';
import '../../data/repository/MovieRepository.dart';


class HomeViewModel extends ChangeNotifier {
  final MovieRepository repository = MovieRepository();

  MovieListModel? movieList;  // فيه كل الداتا اللي جاية من الـ API
  bool isLoading = false;
  String? errorMessage;

  Future<void> getMovies() async {
    try {
      isLoading = true;
      notifyListeners();

      movieList = (await repository.fetchMovies());

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  List<Movies> get movies => movieList?.data?.movies ?? [];
}
