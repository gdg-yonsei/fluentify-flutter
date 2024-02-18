import 'dart:async';

import 'package:fluentify/utils/route.dart';
import 'package:flutter/material.dart';

class PendingScreen<T> extends StatefulWidget {
  final String label;
  final Future<T> Function() action;
  final Widget Function(T) nextScreen;

  const PendingScreen({
    super.key,
    required this.label,
    required this.action,
    required this.nextScreen,
  });

  @override
  State<PendingScreen> createState() => _PendingScreenState<T>();
}

class _PendingScreenState<T> extends State<PendingScreen<T>> {
  @override
  void initState() {
    super.initState();

    widget.action().then(
      (result) {
        Navigator.of(context).pushReplacement(
          generateRoute(
            widget.nextScreen(result),
            transitionType: TransitionType.fade,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).colorScheme.primary,
      child: Hero(
        tag: widget.label,
        child: Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black26,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
