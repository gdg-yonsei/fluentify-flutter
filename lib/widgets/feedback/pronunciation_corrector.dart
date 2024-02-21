import 'package:collection/collection.dart';
import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/widgets/feedback/score_board.dart';
import 'package:flutter/material.dart';

class PronunciationCorrector extends StatelessWidget {
  final SentenceDTO sentence;
  final PronunciationFeedbackDTO feedback;

  const PronunciationCorrector({
    super.key,
    required this.sentence,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 20,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          ScoreBoard(
            pronunciationScore: feedback.pronunciationScore,
            speedScore: feedback.speedScore,
            volumeScore: feedback.volumeScore,
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: sentence.text.split(' ').mapIndexed(
                (index, word) {
                  final prefix = index == 0 ? '' : ' ';

                  return TextSpan(
                    text: '$prefix$word',
                    style: feedback.incorrectIndexes.contains(index)
                        ? const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          )
                        : const TextStyle(color: Colors.blue),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
