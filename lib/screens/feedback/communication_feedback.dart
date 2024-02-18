import 'dart:developer';

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
import 'package:fluentify/widgets/common/recorder.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:flutter/material.dart';

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

  String _generateGuide(FeedbackState state) {
    switch (state) {
      case FeedbackState.ready:
        return 'Press the record button and answer the question with the image below!';
      case FeedbackState.evaluating:
        return "Wait a second! I'm evaluating your pronunciation.";
      case FeedbackState.done:
        return 'This is my feedback!';
    }
  }

  @override
  State<CommunicationFeedbackScreen> createState() =>
      _CommunicationFeedbackScreenState();
}

class _CommunicationFeedbackScreenState
    extends State<CommunicationFeedbackScreen> {
  FeedbackState state = FeedbackState.ready;
  late CommunicationFeedbackDTO feedback;

  void finishRecord(String audioPath) async {
    log('audio path : $audioPath');

    setState(() {
      state = FeedbackState.evaluating;
    });

    feedback = await widget.feedbackService.getCommunicationFeedback(
      sceneId: widget.scene.id,
    );

    setState(() {
      state = FeedbackState.done;
    });
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
              SpeechBubble(
                message: widget._generateGuide(state),
                edgeLocation: EdgeLocation.top,
              ),
              if (state == FeedbackState.ready) ...[
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
