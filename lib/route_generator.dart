import 'package:flutter/material.dart';
import 'package:news_app/pages/bookmarks.dart';
import 'package:news_app/pages/home.dart';
import 'package:news_app/pages/new_details.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args;
    if (settings.arguments != null) {
      args = settings.arguments as Map;
    } else {
      args = null;
    }

    switch (settings.name) {
      case '/':
        return PageTransition(
          child: const Home(),
          settings: const RouteSettings(name: '/'),
          type: PageTransitionType.rightToLeft,
        );
      case '/details':
        return PageTransition(
          child: NewDetails(news: args['news']),
          settings: const RouteSettings(name: '/details'),
          type: PageTransitionType.rightToLeft,
        );
      case '/bookmarks':
        return PageTransition(
          child: const Bookmarks(),
          settings: const RouteSettings(name: '/bookmarks'),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return PageTransition(
      child: const Center(child: Text("error")),
      settings: const RouteSettings(name: "/error"),
      type: PageTransitionType.fade,
    );
  }
}
