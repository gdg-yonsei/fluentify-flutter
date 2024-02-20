import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/interfaces/topic.pb.dart';
import 'package:fluentify/screens/selection/feedback.dart';
import 'package:fluentify/services/topic.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class TopicSelectScreen extends StatelessWidget {
  const TopicSelectScreen({super.key});

  Conversation _generateConversation(
    BuildContext context,
    List<CompactTopicDTO> topics,
  ) {
    return Conversation(
      question: ConversationQuestion(message: "Let's move here!"),
      answers: topics
          .map(
            (topic) => ConversationAnswer(
              message: topic.title,
              onAnswer: (hide, show) async {
                final navigator = Navigator.of(context);

                await hide();
                await navigator.push(
                  generateRoute(
                    FeedbackSelectScreen(topicId: topic.id),
                    transitionType: TransitionType.none,
                  ),
                );
                await show();
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FluentifyAppBar(),
      body: SafeArea(
        child: FutureBuilder(
          future: TopicService.listTopics(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ConversationScaffold(
                conversation: _generateConversation(
                  context,
                  snapshot.data!,
                ),
              );
            }

            return ConversationScaffold(
              conversation: Conversation(
                question: ConversationQuestion(message: "Finding cases..."),
                answers: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
