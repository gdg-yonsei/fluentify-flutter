import 'package:collection/collection.dart';
import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';
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
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text('What you say : ${feedback.transcript}'),
          Text('Pronunciation score : ${feedback.pronunciationScore}'),
          Text('Speed score : ${feedback.speedScore}'),
          Text('Volume score : ${feedback.volumeScore}'),
          Text.rich(
            TextSpan(
              children: sentence.text.characters
                  .mapIndexed(
                    (index, c) => TextSpan(
                      text: c,
                      style: feedback.incorrectIndexes.contains(index)
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
        ],
      ),
    );
  }
}
