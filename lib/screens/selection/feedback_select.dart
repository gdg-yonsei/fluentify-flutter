import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/interfaces/scene.pb.dart';
import 'package:fluentify/interfaces/sentence.pb.dart';
import 'package:fluentify/interfaces/topic.pb.dart';
import 'package:fluentify/repositories/scene.dart';
import 'package:fluentify/repositories/sentence.dart';
import 'package:fluentify/repositories/topic.dart';
import 'package:fluentify/screens/feedback/communication_feedback.dart';
import 'package:fluentify/screens/feedback/pronunciation_feedback.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class FeedbackSelectScreen extends StatelessWidget {
  final TopicRepository topicRepository = TopicRepository();
  final SentenceRepository sentenceRepository = SentenceRepository();
  final SceneRepository sceneRepository = SceneRepository();

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
                    final topicResponse = await topicRepository.getTopic(
                      GetTopicRequest(id: topicId),
                    );
                    final topic = topicResponse.topic;

                    final sentenceResponse =
                        await sentenceRepository.getSentence(
                      GetSentenceRequest(
                        id: topic.sentenceIds[0],
                      ),
                    );
                    final sentence = sentenceResponse.sentence;

                    return (topic, sentence);
                  },
                  nextScreen: (value) {
                    final (topic, sentence) = value;

                    return PronunciationFeedbackScreen(
                      sentenceIds: topic.sentenceIds,
                      index: 1,
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
                    final topicResponse = await topicRepository.getTopic(
                      GetTopicRequest(id: topicId),
                    );
                    final topic = topicResponse.topic;

                    final sceneResponse = await sceneRepository.getScene(
                      GetSceneRequest(
                        id: topic.sentenceIds[0],
                      ),
                    );
                    final scene = sceneResponse.scene;

                    return (topic, scene);
                  },
                  nextScreen: (value) {
                    final (topic, scene) = value;

                    return CommunicationFeedbackScreen(
                      sceneIds: topic.sceneIds,
                      index: 1,
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
