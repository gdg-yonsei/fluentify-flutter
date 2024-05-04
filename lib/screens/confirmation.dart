import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/selection/topic.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(
          message: 'Are you ready? Be sure to wear your own assistive device!'),
      answers: [
        ConversationAnswer(
          message: "Sure. Let's go!",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                const TopicSelectScreen(),
                transitionType: TransitionType.none,
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "Oh! wait a second. Now I'm wearing my assistive device.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            navigator.pop();
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
