import 'package:flutter/material.dart';

import '../../data/Models/MovieDetailsModel.dart';
import '../../data/repository/MovieRepository.dart';


class MovieDetailsViewModel extends ChangeNotifier {
  final MovieRepository _repository = MovieRepository();

  MovieDetailsModel? movieDetails;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getMovieDetails(int movieId) async {
    try {
      isLoading = true;
      notifyListeners();

      movieDetails = await _repository.fetchMovieDetails(movieId);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Getter يسهل الوصول للفيلم نفسه
  Movie? get movie => movieDetails?.data?.movie;
}
