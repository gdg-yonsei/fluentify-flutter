import 'package:fluentify/interfaces/scene.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/avatar.dart';
import 'package:fluentify/widgets/common/speech_bubble.dart';
import 'package:flutter/material.dart';

class CommunicationFeedbackScreen extends StatefulWidget {
  final int index;
  final Scene scene;

  const CommunicationFeedbackScreen({
    super.key,
    required this.index,
    required this.scene,
  });

  @override
  State<CommunicationFeedbackScreen> createState() =>
      _CommunicationFeedbackScreenState();
}

class _CommunicationFeedbackScreenState
    extends State<CommunicationFeedbackScreen> {
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
                  SpeechBubble(message: widget.scene.question),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(30),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic_outlined),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
