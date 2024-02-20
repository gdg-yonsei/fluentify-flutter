import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class AvatarSettingScreen extends StatelessWidget {
  const AvatarSettingScreen({super.key});

  Conversation _generateConversation(BuildContext context) {
    return Conversation(
      question: ConversationQuestion(message: "I'll be your best friend!"),
      answers: [
        ConversationAnswer(
          message: "I want to hear my parent's voice from you.",
          onAnswer: (hide, show) async {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('TODO'),
                  content: Text('Not implemented yet!'),
                );
              },
            );
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
