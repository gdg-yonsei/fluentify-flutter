import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentify/interfaces/feedback.dart';
import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/screens/feedback/complete.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/services/feedback.dart';
import 'package:fluentify/services/sentence.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:fluentify/widgets/feedback/pronunciation_corrector.dart';
import 'package:fluentify/widgets/feedback/recorder.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PronunciationFeedbackScreen extends StatefulWidget {
  final List<String> sentenceIds;
  final int index;
  final SentenceDTO sentence;

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
  late VideoPlayerController _avatarController;
  late Future<void> _initializeAvatar;

  FeedbackState state = FeedbackState.ready;
  late PronunciationFeedbackDTO feedback;

  void finishRecord(String audioPath, String audioName) async {
    setState(() {
      state = FeedbackState.evaluating;
    });

    try {
      final audioFile = File(audioPath);

      final uploadPath = 'audio/$audioName';
      final uploadRef = FirebaseStorage.instance.ref(uploadPath);

      await uploadRef.putFile(audioFile);

      feedback = await FeedbackService.getPronunciationFeedback(
        sentenceId: widget.sentence.id,
        audioPath: uploadPath,
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
                  final sentence = await SentenceService.getSentence(
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
            : const FeedbackCompleteScreen(),
        transitionType: TransitionType.fade,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _avatarController = VideoPlayerController.networkUrl(
      Uri.parse(widget.sentence.exampleVideoUrl),
    );
    _initializeAvatar = _avatarController.initialize();
  }

  @override
  void dispose() {
    _avatarController.dispose();

    super.dispose();
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
              FutureBuilder(
                future: _initializeAvatar,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      clipBehavior: Clip.hardEdge,
                      child: AspectRatio(
                        aspectRatio: _avatarController.value.aspectRatio,
                        child: VideoPlayer(_avatarController..play()),
                      ),
                    );
                  }

                  return const Avatar();
                },
              ),
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
                PronunciationCorrector(
                  sentence: widget.sentence,
                  feedback: feedback,
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
