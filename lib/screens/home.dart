import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/case.dart';
import 'package:fluentify/screens/history.dart';
import 'package:fluentify/screens/settings.dart';
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
          message: "Let's practice new things!",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => CaseScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "I want to recap what we've done!",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
            await show();
          },
        ),
        ConversationAnswer(
          message: "I need to reset my configuration.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await hide();
            await navigator.push(
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
