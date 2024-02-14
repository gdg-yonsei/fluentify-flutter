import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/history.dart';
import 'package:fluentify/screens/settings.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation-template.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  Conversation _generateGreetingConversation(BuildContext context) {
    return Conversation(
      question: 'What are we gonna do today?',
      answerOptions: [
        ConversationAnswerOption(label: "Let's practice new things!"),
        ConversationAnswerOption(
          label: "I want to recap what we've done!",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          },
        ),
        ConversationAnswerOption(
          label: "I need to reset my configuration.",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ],
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FluentifyAppBar(),
      body: SafeArea(
        child: ConversationTemplate(
          conversation: widget._generateGreetingConversation(context),
        ),
      ),
    );
  }
}
