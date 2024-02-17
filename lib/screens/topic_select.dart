import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/feedback_select.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class TopicSelectScreen extends StatelessWidget {
  const TopicSelectScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(message: "Let's move here!"),
      answers: [
        ConversationAnswer(
          message: "Bus stop",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                const FeedbackSelectScreen(topicId: 1),
                transitionType: TransitionType.none,
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "Hospital",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                const FeedbackSelectScreen(topicId: 2),
                transitionType: TransitionType.none,
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "School",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                const FeedbackSelectScreen(topicId: 3),
                transitionType: TransitionType.none,
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
