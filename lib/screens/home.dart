import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/case.dart';
import 'package:fluentify/screens/history.dart';
import 'package:fluentify/screens/settings.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  Conversation _generateGreetingConversation(BuildContext context) {
    return Conversation(
      question: 'What are we gonna do today?',
      answerOptions: [
        ConversationAnswerOption(
          message: "Let's practice new things!",
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => CaseScreen(),
                transitionsBuilder:
                    (context, startAnimation, endAnimation, child) =>
                        FadeTransition(opacity: startAnimation, child: child),
              ),
            );
          },
        ),
        ConversationAnswerOption(
          message: "I want to recap what we've done!",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
          },
        ),
        ConversationAnswerOption(
          message: "I need to reset my configuration.",
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
        child: ConversationScaffold(
          conversation: widget._generateGreetingConversation(context),
        ),
      ),
    );
  }
}
