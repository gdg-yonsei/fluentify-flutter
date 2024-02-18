import 'package:fluentify/interfaces/conversation.dart';
import 'package:fluentify/screens/home.dart';
import 'package:fluentify/utils/route.dart';
import 'package:fluentify/widgets/common/appbar.dart';
import 'package:fluentify/widgets/common/conversation_scaffold.dart';
import 'package:flutter/material.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FluentifyAppBar(),
      body: SafeArea(
        child: ConversationScaffold(
          conversation: Conversation(
            question: ConversationQuestion(
              message: "Now we're done!",
            ),
            answers: [
              ConversationAnswer(
                message: 'Go back to home',
                onAnswer: (hide, show) async {
                  final navigator = Navigator.of(context);

                  await hide();
                  await navigator.pushAndRemoveUntil(
                    generateRoute(
                      const HomeScreen(),
                      transitionType: TransitionType.none,
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
