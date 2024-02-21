import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentify/interfaces/feedback.dart';
import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/screens/feedback/complete.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/services/feedback.dart';
import 'package:fluentify/services/scene.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:fluentify/widgets/feedback/recorder.dart';
import 'package:flutter/material.dart';

class CommunicationFeedbackScreen extends StatefulWidget {
  final List<String> sceneIds;

  final int index;
  final SceneDTO scene;

  const CommunicationFeedbackScreen({
    super.key,
    required this.sceneIds,
    required this.index,
    required this.scene,
  });

  @override
  State<CommunicationFeedbackScreen> createState() =>
      _CommunicationFeedbackScreenState();
}

class _CommunicationFeedbackScreenState
    extends State<CommunicationFeedbackScreen> {
  FeedbackState state = FeedbackState.ready;
  late CommunicationFeedbackDTO feedback;

  void finishRecord(String audioPath, String audioName) async {
    setState(() {
      state = FeedbackState.evaluating;
    });

    try {
      final audioFile = File(audioPath);

      final uploadPath = 'audio/$audioName';
      final uploadRef = FirebaseStorage.instance.ref(uploadPath);

      await uploadRef.putFile(audioFile);

      feedback = await FeedbackService.getCommunicationFeedback(
        sceneId: widget.scene.id,
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
        nextIndex < widget.sceneIds.length
            ? PendingScreen(
                label: 'Case ${nextIndex + 1}',
                action: () async {
                  final scene = await SceneService.getScene(
                    id: widget.sceneIds[nextIndex],
                  );

                  return scene;
                },
                nextScreen: (scene) {
                  return CommunicationFeedbackScreen(
                    sceneIds: widget.sceneIds,
                    index: nextIndex,
                    scene: scene,
                  );
                },
              )
            : const FeedbackCompleteScreen(),
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
                      'Press the record button and answer the question with the image below!',
                  edgeLocation: EdgeLocation.top,
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(widget.scene.imageUrl),
                  ),
                ),
                const SizedBox(height: 10),
                SpeechBubble(message: '"${widget.scene.question}"'),
              ],
              if (state == FeedbackState.evaluating) ...[
                const SpeechBubble(
                  message: "Wait a second!\nI'm evaluating your speech.",
                  edgeLocation: EdgeLocation.top,
                ),
              ],
              if (state == FeedbackState.done) ...[
                SpeechBubble(
                  message: feedback.positiveFeedback,
                  edgeLocation: EdgeLocation.top,
                ),
                SpeechBubble(message: feedback.negativeFeedback),
                SpeechBubble(message: feedback.enhancedAnswer),
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
