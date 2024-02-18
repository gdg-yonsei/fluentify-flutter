import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class Corrector extends StatelessWidget {
  final String text;
  final List<int> incorrectIndexes;

  const Corrector({
    super.key,
    required this.text,
    required this.incorrectIndexes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: text.characters
              .mapIndexed(
                (index, c) => TextSpan(
                  text: c,
                  style: incorrectIndexes.contains(index)
                      ? const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        )
                      : null,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
