import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentify/interfaces/feedback.dart';
import 'package:fluentify/interfaces/feedback.pb.dart';
import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/screens/complete.dart';
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
import 'package:uuid/uuid.dart';

class CommunicationFeedbackScreen extends StatefulWidget {
  final SceneService sceneService = SceneService();
  final FeedbackService feedbackService = FeedbackService();

  final List<String> sceneIds;

  final int index;
  final SceneDTO scene;

  CommunicationFeedbackScreen({
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

  void finishRecord(String audioPath) async {
    setState(() {
      state = FeedbackState.evaluating;
    });

    final storageRef = FirebaseStorage.instance.ref();
    final targetRef = storageRef.child('user-upload/${const Uuid().v4()}.m4a');

    try {
      final audioFile = File(audioPath);
      final audioRef = await targetRef.putFile(audioFile);

      feedback = await widget.feedbackService.getCommunicationFeedback(
        sceneId: widget.scene.id,
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
        nextIndex < widget.sceneIds.length
            ? PendingScreen(
                label: 'Case ${nextIndex + 1}',
                action: () async {
                  final scene = await widget.sceneService.getScene(
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
                  message: feedback.overallFeedback,
                  edgeLocation: EdgeLocation.top,
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
