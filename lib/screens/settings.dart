import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(message: 'What do you want to do?'),
      answers: [
        ConversationAnswer(
          message: "I want to log out.",
          onAnswer: (hide, show) async {
            final navigator = Navigator.of(context);

            await FirebaseAuth.instance.signOut();

            navigator.popUntil((route) => route.isFirst);
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
