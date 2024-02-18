import 'dart:developer';

import 'package:fluentify/interfaces/feedback.dart';
import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/screens/complete.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/services/feedback.dart';
import 'package:fluentify/services/sentence.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/recorder.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:flutter/material.dart';

class PronunciationFeedbackScreen extends StatefulWidget {
  final SentenceService sentenceService = SentenceService();
  final FeedbackService feedbackService = FeedbackService();

  final List<String> sentenceIds;
  final int index;
  final SentenceDTO sentence;

  PronunciationFeedbackScreen({
    super.key,
    required this.sentenceIds,
    required this.index,
    required this.sentence,
  });

  String _generateGuide(FeedbackState state) {
    switch (state) {
      case FeedbackState.ready:
        return 'Press the record button and say the sentence below!';
      case FeedbackState.evaluating:
        return "Wait a second! I'm evaluating your pronunciation.";
      case FeedbackState.done:
        return 'This is my feedback!';
    }
  }

  @override
  State<PronunciationFeedbackScreen> createState() =>
      _PronunciationFeedbackScreenState();
}

class _PronunciationFeedbackScreenState
    extends State<PronunciationFeedbackScreen> {
  FeedbackState state = FeedbackState.ready;
  late PronunciationFeedbackDTO feedback;

  void finishRecord(String audioPath) async {
    log('audio path : $audioPath');

    setState(() {
      state = FeedbackState.evaluating;
    });

    feedback = await widget.feedbackService.getPronunciationFeedback(
      sentenceId: widget.sentence.id,
    );

    setState(() {
      state = FeedbackState.done;
    });
  }

  void goNext() {
    final nextIndex = widget.index + 1;

    Navigator.of(context).pushReplacement(
      generateRoute(
        nextIndex < widget.sentenceIds.length
            ? PendingScreen(
                label: 'Case ${nextIndex + 1}',
                action: () async {
                  final sentence = await widget.sentenceService.getSentence(
                    id: widget.sentenceIds[nextIndex],
                  );

                  return sentence;
                },
                nextScreen: (sentence) {
                  return PronunciationFeedbackScreen(
                    sentenceIds: widget.sentenceIds,
                    index: nextIndex,
                    sentence: sentence,
                  );
                },
              )
            : const CompleteScreen(),
        transitionType: TransitionType.fade,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FluentifyAppBar(
        title: Hero(
          tag: 'Case ${widget.index + 1}',
          child: Text(
            'Case ${widget.index + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Splitter(
          padding: 20,
          top: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Avatar(),
              const SizedBox(height: 30),
              SpeechBubble(
                message: widget._generateGuide(state),
                edgeLocation: EdgeLocation.top,
              ),
              if (state == FeedbackState.ready) ...[
                const SizedBox(height: 10),
                SpeechBubble(message: '"${widget.sentence.text}"'),
              ],
              if (state == FeedbackState.done) ...[
                const SizedBox(height: 10),
                SpeechBubble(message: feedback.overallFeedback),
              ],
            ],
          ),
          bottom: Column(
            children: [
              if (state == FeedbackState.ready)
                Recorder(onFinishRecord: finishRecord),
              if (state == FeedbackState.done)
                SpeechBubble(
                  message: "I got it! Let's go next step!",
                  edgeLocation: EdgeLocation.bottom,
                  onTap: goNext,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
