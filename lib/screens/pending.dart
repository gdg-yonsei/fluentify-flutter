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
          transitionsBuilder: (context, animation1, animation2, child) {
            return animation1.status == AnimationStatus.forward
                ? FadeTransition(
                    opacity: animation1,
                    child: child,
                  )
                : SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0), // Slide from bottom
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation1,
                      curve: Curves.ease,
                    )),
                    child: child,
                  );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.primary,
      child: Hero(
        tag: widget.title,
        child: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black26,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
