import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/feedback/communication_feedback.dart';
import 'package:fluentify/screens/feedback/pronunciation_feedback.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/services/scene.dart';
import 'package:fluentify/services/sentence.dart';
import 'package:fluentify/services/topic.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class FeedbackSelectScreen extends StatelessWidget {
  final TopicService topicService = TopicService();
  final SentenceService sentenceService = SentenceService();
  final SceneService sceneService = SceneService();

  final String topicId;

  FeedbackSelectScreen({super.key, required this.topicId});

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
                  action: () async {
                    final topic = await topicService.getTopic(id: topicId);
                    final sentence = await sentenceService.getSentence(
                      id: topic.sentenceIds[0],
                    );

                    return (topic, sentence);
                  },
                  nextScreen: (value) {
                    final (topic, sentence) = value;

                    return PronunciationFeedbackScreen(
                      sentenceIds: topic.sentenceIds,
                      index: 0,
                      sentence: sentence,
                    );
                  },
                ),
                transitionType: TransitionType.fade,
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "I want to practice my communication.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                PendingScreen(
                  label: 'Case 1',
                  action: () async {
                    final topic = await topicService.getTopic(id: topicId);
                    final scene = await sceneService.getScene(
                      id: topic.sceneIds[0],
                    );

                    return (topic, scene);
                  },
                  nextScreen: (value) {
                    final (topic, scene) = value;

                    return CommunicationFeedbackScreen(
                      sceneIds: topic.sceneIds,
                      index: 0,
                      scene: scene,
                    );
                  },
                ),
                transitionType: TransitionType.fade,
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
