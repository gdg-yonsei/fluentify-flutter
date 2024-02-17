import 'package:fluentify/data/samples.dart';
import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/feedback/communication_feedback.dart';
import 'package:fluentify/screens/feedback/pronunciation_feedback.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class FeedbackSelectScreen extends StatelessWidget {
  final int topicId;

  const FeedbackSelectScreen({super.key, required this.topicId});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(message: "What do you want to practice?"),
      answers: [
        ConversationAnswer(
          message: "I want to practice my pronunciation.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                PendingScreen(
                  label: 'Case 1',
                  action: () {
                    return Future.delayed(
                      const Duration(seconds: 2),
                      () => sampleSentences[0],
                    );
                  },
                  nextScreen: (sentence) => PronunciationFeedbackScreen(
                    index: 1,
                    sentence: sentence,
                  ),
                ),
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "I want to practice my communication",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                PendingScreen(
                  label: 'Case 1',
                  action: () {
                    return Future.delayed(
                      const Duration(seconds: 2),
                      () => sampleScenes[0],
                    );
                  },
                  nextScreen: (scene) => CommunicationFeedbackScreen(
                    index: 1,
                    scene: scene,
                  ),
                ),
              ),
            );
            await show();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FluentifyAppBar(),
      body: SafeArea(
        child: ConversationScaffold(
          conversation: _generateConversation(context),
        ),
      ),
    );
  }
}
