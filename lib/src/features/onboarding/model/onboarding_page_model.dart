import 'dart:ui';

class OnboardingPageModel {
  final String imagePath;
  final Color color;
  final String title;
  final String description;
  final String buttonText;

  OnboardingPageModel({
    required this.imagePath,
    required this.color,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}