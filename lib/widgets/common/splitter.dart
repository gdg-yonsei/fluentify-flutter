import 'package:flutter/material.dart';

class Splitter extends StatelessWidget {
  final Widget top;
  final Widget bottom;
  final double padding;

  const Splitter({
    super.key,
    required this.top,
    required this.bottom,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: top,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(padding),
          child: bottom,
        ),
      ],
    );
  }
}
