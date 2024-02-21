import 'dart:developer';

import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int pronunciationScore;
  final int speedScore;
  final int volumeScore;

  const ScoreBoard({
    super.key,
    required this.pronunciationScore,
    required this.speedScore,
    required this.volumeScore,
  });

  IconData _getScoreIcon(int score) {
    switch (score) {
      case 5:
        return Icons.sentiment_very_satisfied;
      case 4:
        return Icons.sentiment_satisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 1:
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    log('$pronunciationScore $speedScore $volumeScore');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            children: [
              const Text('Pronunciation'),
              const SizedBox(height: 10),
              Icon(_getScoreIcon(pronunciationScore), size: 50),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text('Speed'),
              const SizedBox(height: 10),
              Icon(_getScoreIcon(speedScore), size: 50),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              const Text('Volume'),
              const SizedBox(height: 10),
              Icon(_getScoreIcon(volumeScore), size: 50),
            ],
          ),
        ),
      ],
    );
  }
}
