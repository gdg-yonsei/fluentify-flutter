import 'dart:async';

import 'package:flutter/material.dart';

class PendingScreen extends StatefulWidget {
  final Widget nextScreen;
  final String title;
  final Duration delay;

  const PendingScreen({
    super.key,
    required this.nextScreen,
    required this.title,
    this.delay = const Duration(seconds: 2),
  });

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(widget.delay, () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => widget.nextScreen,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.primary,
      child: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black26,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
