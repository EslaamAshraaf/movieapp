import 'package:flutter/material.dart';
import '../../model/onboarding_page_model.dart';

class OnboardingViewModel {
  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      imagePath: "assets/images/avengers.png",
      color: const Color(0xff084250),
      title: "Discover Movies",
      description: "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      buttonText: "Next",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/openheimer.png",
      color: const Color(0xff85210E),
      title: "Explore All Genres",
      description: "Discover movies from every genre, in all available qualities. Find something new and exciting to watch each day.",
      buttonText: "Next",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/badboys.png",
      color: const Color(0xff4C2471),
      title: "Create Watchlists",
      description: "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
      buttonText: "Next",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/drstrange.png",
      color: const Color(0xff601321),
      title: "Rate, Review, and Learn",
      description: "Share your thoughts on movies, dive into film details, and help others discover great movies with your reviews.",
      buttonText: "Next",
    ),
    OnboardingPageModel(
      imagePath: "assets/images/voodwar.png",
      color: const Color(0xff2A2C30),
      title: "Start Watching Now",
      description: "Begin your movie journey today. Find, watch, and enjoy.",
      buttonText: "Finish",
    ),
  ];
}
