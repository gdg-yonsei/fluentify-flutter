import 'dart:developer';

import 'package:fluentify/interfaces/feedback.dart';
import 'package:fluentify/interfaces/scene.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/recorder.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:fluentify/widgets/common/splitter.dart';
import 'package:flutter/material.dart';

class CommunicationFeedbackScreen extends StatefulWidget {
  final List<int> sceneIds;

  final int index;
  final Scene scene;

  const CommunicationFeedbackScreen({
    super.key,
    required this.sceneIds,
    required this.index,
    required this.scene,
  });

  String _generateGuide(FeedbackState state) {
    switch (state) {
      case FeedbackState.ready:
        return 'Press the record button and answer the question with the image below!';
      case FeedbackState.recording:
        return "Now I'm listening!";
      case FeedbackState.evaluating:
        return "Wait a second! I'm evaluating your pronunciation.";
      case FeedbackState.done:
        return 'Perfect!';
    }
  }

  @override
  State<CommunicationFeedbackScreen> createState() =>
      _CommunicationFeedbackScreenState();
}

class _CommunicationFeedbackScreenState
    extends State<CommunicationFeedbackScreen> {
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
          ),
          bottom: Column(
            children: [
              if (state == FeedbackState.ready ||
                  state == FeedbackState.recording)
                Recorder(
                  isRecording: state == FeedbackState.recording,
                  onStartRecord: startRecord,
                  onFinishRecord: finishRecord,
                ),
              if (state == FeedbackState.done)
                const SpeechBubble(
                  message: "I got it! Let's go next step!",
                  edgeLocation: EdgeLocation.bottom,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
