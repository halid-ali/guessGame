import 'package:flutter/material.dart';
import 'package:guessGame/screens/splash_screen.dart';

class RouteGenerator {
  static const homePage = '/';

  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute<SplashScreen>(
          builder: (_) => SplashScreen(),
        );
      default:
        throw RouteException("Route not found.");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
