import 'package:flutter/material.dart';

enum TransitionType { system, fade, none }

Route generateRoute(Widget nextScreen,
    {TransitionType transitionType = TransitionType.system}) {
  switch (transitionType) {
    case TransitionType.fade:
      return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    case TransitionType.none:
      return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextScreen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      );
    default:
      return MaterialPageRoute(
        builder: (context) => nextScreen,
      );
  }
}
