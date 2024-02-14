import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/case.dart';
import 'package:fluentify/screens/pending.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({super.key});

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
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => PendingScreen(
                  nextScreen: CaseScreen(),
                  title: 'Bus Stop',
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
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
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => PendingScreen(
                  nextScreen: CaseScreen(),
                  title: 'Hospital',
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
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
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => PendingScreen(
                  nextScreen: CaseScreen(),
                  title: 'School',
                ),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
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
