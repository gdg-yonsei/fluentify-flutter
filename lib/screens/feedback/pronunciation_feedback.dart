import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:fluentify/widgets/feedback/corrector.dart';
import 'package:fluentify/widgets/feedback/recorder.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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

  @override
  State<PronunciationFeedbackScreen> createState() =>
      _PronunciationFeedbackScreenState();
}

class _PronunciationFeedbackScreenState
    extends State<PronunciationFeedbackScreen> {
  FeedbackState state = FeedbackState.ready;
  late PronunciationFeedbackDTO feedback;

  void finishRecord(String audioPath) async {
    setState(() {
      state = FeedbackState.evaluating;
    });

    final storageRef = FirebaseStorage.instance.ref();
    final targetRef = storageRef.child('user-upload/${const Uuid().v4()}.m4a');

    try {
      final audioFile = File(audioPath);
      final audioRef = await targetRef.putFile(audioFile);

      feedback = await widget.feedbackService.getPronunciationFeedback(
        sentenceId: widget.sentence.id,
        audioFileUrl: await audioRef.ref.getDownloadURL(),
      );

      setState(() {
        state = FeedbackState.done;
      });
    } catch (e) {
      setState(() {
        state = FeedbackState.ready;
      });
    }
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
              if (state == FeedbackState.ready) ...[
                const SpeechBubble(
                  message:
                      'Press the record button and say the sentence below!',
                  edgeLocation: EdgeLocation.top,
                ),
                const SizedBox(height: 10),
                SpeechBubble(message: '"${widget.sentence.text}"'),
              ],
              if (state == FeedbackState.evaluating) ...[
                const SpeechBubble(
                  message: "Wait a second!\nI'm evaluating your pronunciation.",
                  edgeLocation: EdgeLocation.top,
                ),
              ],
              if (state == FeedbackState.done) ...[
                SpeechBubble(
                  message: feedback.overallFeedback,
                  edgeLocation: EdgeLocation.top,
                ),
                const SizedBox(height: 10),
                const SpeechBubble(
                  message:
                      'The below one is the corrected version of your speech.',
                ),
                const SizedBox(height: 10),
                Corrector(
                  text: widget.sentence.text,
                  incorrectIndexes: feedback.incorrectIndexes,
                ),
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
