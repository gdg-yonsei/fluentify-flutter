import 'package:flutter/material.dart';

class Popper extends StatelessWidget {
  final bool visible;
  final Widget child;

  const Popper({super.key, required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedScale(
        scale: visible ? 1 : 0.9,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        child: child,
      ),
    );
  }
}
