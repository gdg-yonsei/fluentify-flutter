import 'package:fluentify/data/samples.dart';
import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/selection/feedback_select.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class TopicSelectScreen extends StatelessWidget {
  const TopicSelectScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(message: "Let's move here!"),
      answers: sampleTopics
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
        child: ConversationScaffold(
          conversation: _generateConversation(context),
        ),
      ),
    );
  }
}
