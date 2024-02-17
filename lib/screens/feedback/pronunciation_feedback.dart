import 'dart:developer';

import 'package:fluentify/interfaces/feedback.dart';
import 'package:fluentify/interfaces/sentence.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/recorder.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';

class PronunciationFeedbackScreen extends StatefulWidget {
  final List<int> sentenceIds;

  final int index;
  final Sentence sentence;

  const PronunciationFeedbackScreen({
    super.key,
    required this.sentenceIds,
    required this.index,
    required this.sentence,
  });

  @override
  State<PronunciationFeedbackScreen> createState() =>
      _PronunciationFeedbackScreenState();
}

class _PronunciationFeedbackScreenState
    extends State<PronunciationFeedbackScreen> {
  FeedbackState state = FeedbackState.ready;

  void startRecord() {
    setState(() {
      state = FeedbackState.recording;
    });
  }

  void finishRecord() {
    setState(() {
      state = FeedbackState.evaluating;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        state = FeedbackState.done;
      });
    });
  }

  void goNext() {
    log('Next step');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FluentifyAppBar(
        title: Hero(
          tag: 'Case ${widget.index}',
          child: Text(
            'Case ${widget.index}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Avatar(),
                  const SizedBox(height: 30),
                  SpeechBubble(message: widget.sentence.text),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state == FeedbackState.done) ...[
                      SpeechBubble(
                        message: "Go next step!",
                        edgeLocation: EdgeLocation.bottom,
                        onTap: goNext,
                      ),
                    ],
                    if (state == FeedbackState.evaluating) ...[
                      const SpeechBubble(
                        message:
                            "Wait a second! Now I'm evaluating your pronunciation.",
                        edgeLocation: EdgeLocation.bottom,
                      ),
                    ],
                    if (state == FeedbackState.recording) ...[
                      const SpeechBubble(
                        message: "Now I'm recording!",
                        edgeLocation: EdgeLocation.bottom,
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (state == FeedbackState.ready ||
                        state == FeedbackState.recording)
                      Recorder(
                        isRecording: state == FeedbackState.recording,
                        onStartRecord: startRecord,
                        onFinishRecord: finishRecord,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
