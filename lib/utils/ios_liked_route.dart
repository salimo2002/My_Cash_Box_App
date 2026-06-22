import 'package:flutter/material.dart';

Route iosLikeRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var inAnimation = Tween(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation);

      var outAnimation = Tween(
        begin: Offset.zero,
        end: const Offset(-0.3, 0.0),
      ).animate(secondaryAnimation);

      return SlideTransition(
        position: inAnimation,
        child: SlideTransition(position: outAnimation, child: child),
      );
    },
  );
}
