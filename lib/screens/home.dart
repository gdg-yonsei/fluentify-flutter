import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/selection/topic.dart';
import 'package:fluentify/screens/settings/index.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(message: 'What are we gonna do today?'),
      answers: [
        ConversationAnswer(
          message: "Let's practice!",
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
          message: "I want to configure this app.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              generateRoute(
                const SettingsScreen(),
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
